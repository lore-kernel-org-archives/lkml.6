Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AG47ELtvFN7lLm39Ueu0Hfx8vsYq12LhSDksYvtMYcR8ErobeP1EY0YYLDCI7NKF563bjPGBU9uD
ARC-Seal: i=1; a=rsa-sha256; t=1519947140; cv=none;
        d=google.com; s=arc-20160816;
        b=LIw49VoDKNeuQTdt/XoQPdfHB3GDhQx/RDKxXri9PM85RCHe82y44rApfVw6gase+1
         ekFoguXfQ6MHOTnMnaE+OJYUeWw/db81cxsED/psi+n15QtDFjbN3fjuc0eZ7kYOLxHI
         sSYNdPPlx3R36OJkZQlJ3YIYj+I+zqpcA2lM/2kgDx1dkjVLSFq4T5I7QQaRioxEiS0C
         RrYu4cwYtwAL3uqvmYPhaEPr/xeJc4wATR1xv6tfoaAkqd2zTEqrGex9Nd1cCPQoeaTB
         OJY6E938kVuom8BTnAak0QDJcCxFZw6q+0lQTJjmvhS8ya1kiVpFlbPOQ2nvbsUKbdq6
         PI/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=hVEBx66NAwSFA6itCxLf8NEvD55m31tXDRBFGvtCFnk=;
        b=wTTacAZbrG3lnLHbvSnBXT/q48sJwvum2vBNclU4vb0JBARCT2qIUVJcEsTxf7iKBx
         a0JKqOxqOmzPx9+E9mYhcsv+ASvNCEIXePHk3hKzjWAqkHhMmrp/dOxp/vcoXTctWa92
         XfgfXq3jyc/EhqOdzbRgiUKpeLn9gVXu4kl1tbsrlvR2nIt/cQpsjsAkOx8/b2zdvAfr
         mzpn01TVWrzLU+Yx1G6J6P5AkNmOq8JrKkne4bDRVlHlVwQJBl0EMQD39/73VyfsGCHg
         8km/OsylFPF9YcIaDLtM4HPV8c0VnOavJX8grgl/D1nqG0BJocb0Kq/qlHF9MNB7rRw0
         zoyg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Fri, 02 Mar 2018 10:31:25 +1100
Subject: [PATCH 01/17] staging: lustre: obd_mount: use correct niduuid
 suffix.
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <151994708505.7628.14486515694497834046.stgit@noble>
In-Reply-To: <151994679573.7628.1024109499321778846.stgit@noble>
References: <151994679573.7628.1024109499321778846.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593780092789969683?=
X-GMAIL-MSGID: =?utf-8?q?1593780092789969683?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit 4f016420d368 ("Staging: lustre: obdclass: Use kasprintf") moved
some sprintf() calls earlier in the code to combine them with
memory allocation and create kasprintf() calls.

In one case, this code movement moved the sprintf to a location where the
values being formatter were different.
In particular
       sprintf(niduuid, "%s_%x", mgcname, i);
was move from *after* the line
        i = 0;
to a location where the value of 'i' was at least 1.

This cause the wrong name to be formatted, and triggers

       CERROR("del MDC UUID %s failed: rc = %d\n",
              niduuid, rc);

at unmount time.

So use '0' instead of 'i'.

Fixes: 4f016420d368 ("Staging: lustre: obdclass: Use kasprintf")
Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/obdclass/obd_mount.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/lustre/lustre/obdclass/obd_mount.c b/drivers/staging/lustre/lustre/obdclass/obd_mount.c
index acc1ea773c9c..f5e8214ac37b 100644
--- a/drivers/staging/lustre/lustre/obdclass/obd_mount.c
+++ b/drivers/staging/lustre/lustre/obdclass/obd_mount.c
@@ -243,7 +243,7 @@ int lustre_start_mgc(struct super_block *sb)
 	libcfs_nid2str_r(nid, nidstr, sizeof(nidstr));
 	mgcname = kasprintf(GFP_NOFS,
 			    "%s%s", LUSTRE_MGC_OBDNAME, nidstr);
-	niduuid = kasprintf(GFP_NOFS, "%s_%x", mgcname, i);
+	niduuid = kasprintf(GFP_NOFS, "%s_%x", mgcname, 0);
 	if (!mgcname || !niduuid) {
 		rc = -ENOMEM;
 		goto out_free;
