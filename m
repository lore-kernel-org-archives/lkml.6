Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqpMKujOx3EtWCLpPaNioD11+xebGQzuwicCSiWpZDyL11NOfTosSe6zO2q9I5mq0qEbkly
ARC-Seal: i=1; a=rsa-sha256; t=1525767253; cv=none;
        d=google.com; s=arc-20160816;
        b=q/a7bEmjSs8HMhX6XK++OsUlks2pTH1QJrCTrgwPamdPhbEAW9q3rWtRtcPCIRuVzl
         kWr3r6BnZjAQptEu2hKVrCNbnThJqXYyswsyIpkqYJLIOptzB5Y/EAMK2m39t2T2xSGR
         fFe/C832uVPd3WyI40WUlyr/oBLPZ9ySUALc5UUXrtJ1X8YSfWBqQP1MoTGI/915mVHD
         fTuR7LclisrYyMt7W5OEhlyJYIrTQhX2VJm47MiIZMl6kyHeZA3j8/wtjHe2hmPsksVb
         RhSxqjMA+YjxEkkIqvCP+PgIL3YHtTLPdl0nWF1IGOnwBK1KdkOpKMP9Msdv6JFobOmx
         OOQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=DpiEOoTaj/ZESbKfh+oSMivch2l8NDNnhnfR42Kxj7w=;
        b=GtbKFx5NaUxPP27rLjKCxJkKCRJjlJL1X580L7lwtYHdzqz3fAgZfU0rmC7R9fVE96
         SbgmMdlV0MO9KcGZkY6Nl4p1LYOJy+j83XM450rpKwyYmFKhUbWaoa37Cs+AhlBTx5BV
         LEdEgHHkfJPnRbHnwRB94VUuNKEQ2hOxdgqBMxP74M3da/dui80Q1c1LK0ve1Pu91Lpg
         RWxqDerzgl3YAtH+rjCEvJLKwLcVuXCYYb6XwRMeEBBYUHrny7RSjDOTWVPY/wNdb9Jb
         w+eTiE035BxceoAAv2yAgfZh+6KHDF8PITZxo/38uYyY7WkBZV7NJbED3SrwC6NvMtzX
         S3PQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=sR9kDG26;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=sR9kDG26;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Howard McLauchlan <hmclauchlan@fb.com>,
	Josef Bacik <jbacik@fb.com>,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Song Liu <songliubraving@fb.com>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.16 52/52] tracing: Fix bad use of igrab in trace_uprobe.c
Date: Tue,  8 May 2018 10:10:50 +0200
Message-Id: <20180508073935.457157327@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882923525854548?=
X-GMAIL-MSGID: =?utf-8?q?1599882923525854548?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Song Liu <songliubraving@fb.com>

commit 0c92c7a3c5d416f47b32c5f20a611dfeca5d5f2e upstream.

As Miklos reported and suggested:

  This pattern repeats two times in trace_uprobe.c and in
  kernel/events/core.c as well:

      ret = kern_path(filename, LOOKUP_FOLLOW, &path);
      if (ret)
          goto fail_address_parse;

      inode = igrab(d_inode(path.dentry));
      path_put(&path);

  And it's wrong.  You can only hold a reference to the inode if you
  have an active ref to the superblock as well (which is normally
  through path.mnt) or holding s_umount.

  This way unmounting the containing filesystem while the tracepoint is
  active will give you the "VFS: Busy inodes after unmount..." message
  and a crash when the inode is finally put.

  Solution: store path instead of inode.

This patch fixes two instances in trace_uprobe.c. struct path is added to
struct trace_uprobe to keep the inode and containing mount point
referenced.

Link: http://lkml.kernel.org/r/20180423172135.4050588-1-songliubraving@fb.com

Fixes: f3f096cfedf8 ("tracing: Provide trace events interface for uprobes")
Fixes: 33ea4b24277b ("perf/core: Implement the 'perf_uprobe' PMU")
Cc: stable@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Howard McLauchlan <hmclauchlan@fb.com>
Cc: Josef Bacik <jbacik@fb.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Acked-by: Miklos Szeredi <mszeredi@redhat.com>
Reported-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_uprobe.c |   24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -55,6 +55,7 @@ struct trace_uprobe {
 	struct list_head		list;
 	struct trace_uprobe_filter	filter;
 	struct uprobe_consumer		consumer;
+	struct path			path;
 	struct inode			*inode;
 	char				*filename;
 	unsigned long			offset;
@@ -287,7 +288,7 @@ static void free_trace_uprobe(struct tra
 	for (i = 0; i < tu->tp.nr_args; i++)
 		traceprobe_free_probe_arg(&tu->tp.args[i]);
 
-	iput(tu->inode);
+	path_put(&tu->path);
 	kfree(tu->tp.call.class->system);
 	kfree(tu->tp.call.name);
 	kfree(tu->filename);
@@ -361,7 +362,6 @@ end:
 static int create_trace_uprobe(int argc, char **argv)
 {
 	struct trace_uprobe *tu;
-	struct inode *inode;
 	char *arg, *event, *group, *filename;
 	char buf[MAX_EVENT_NAME_LEN];
 	struct path path;
@@ -369,7 +369,6 @@ static int create_trace_uprobe(int argc,
 	bool is_delete, is_return;
 	int i, ret;
 
-	inode = NULL;
 	ret = 0;
 	is_delete = false;
 	is_return = false;
@@ -435,21 +434,16 @@ static int create_trace_uprobe(int argc,
 	}
 	/* Find the last occurrence, in case the path contains ':' too. */
 	arg = strrchr(argv[1], ':');
-	if (!arg) {
-		ret = -EINVAL;
-		goto fail_address_parse;
-	}
+	if (!arg)
+		return -EINVAL;
 
 	*arg++ = '\0';
 	filename = argv[1];
 	ret = kern_path(filename, LOOKUP_FOLLOW, &path);
 	if (ret)
-		goto fail_address_parse;
-
-	inode = igrab(d_inode(path.dentry));
-	path_put(&path);
+		return ret;
 
-	if (!inode || !S_ISREG(inode->i_mode)) {
+	if (!d_is_reg(path.dentry)) {
 		ret = -EINVAL;
 		goto fail_address_parse;
 	}
@@ -488,7 +482,7 @@ static int create_trace_uprobe(int argc,
 		goto fail_address_parse;
 	}
 	tu->offset = offset;
-	tu->inode = inode;
+	tu->path = path;
 	tu->filename = kstrdup(filename, GFP_KERNEL);
 
 	if (!tu->filename) {
@@ -556,7 +550,7 @@ error:
 	return ret;
 
 fail_address_parse:
-	iput(inode);
+	path_put(&path);
 
 	pr_info("Failed to parse address or file.\n");
 
@@ -935,6 +929,7 @@ probe_event_enable(struct trace_uprobe *
 		goto err_flags;
 
 	tu->consumer.filter = filter;
+	tu->inode = d_real_inode(tu->path.dentry);
 	ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
 	if (ret)
 		goto err_buffer;
@@ -980,6 +975,7 @@ probe_event_disable(struct trace_uprobe
 	WARN_ON(!uprobe_filter_is_empty(&tu->filter));
 
 	uprobe_unregister(tu->inode, tu->offset, &tu->consumer);
+	tu->inode = NULL;
 	tu->tp.flags &= file ? ~TP_FLAG_TRACE : ~TP_FLAG_PROFILE;
 
 	uprobe_buffer_disable();
