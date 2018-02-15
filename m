Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224X/db0RuoPNcOXervnY67mAfMGY8SqyCHFY+Ai8KOWZN/YsT/McXLur717esjH56Gz4sVv
ARC-Seal: i=1; a=rsa-sha256; t=1518708973; cv=none;
        d=google.com; s=arc-20160816;
        b=L6XPSgsW2pgIxlK5h7zP4p6wGOnhdRAvr0YKa95f7eUj26QIUfkxjkL5x2ZWDio5A7
         8e+xTi6tQtIWwu2JPn1ixedfIbUhrMrIrH8n0BkawINdmmv639TLW8up1EzKbaBGqoI6
         lgJL3qB633KLlhkY6UjVOGW9S13TNHDyPkhnrdddTUQx+W8hYoI+7tfe3muHuD0ItcO3
         v48U/GZ6UaJK1L8yVudN605rXr3boj8O14KX1ds4xCkMYbjsaaYIgkjB+TfNWul+497u
         IgMaZ9Y+hgquvZDVSW3GGbhyS2iH7yZHqXAz5RSOZ4W+hZjadHWV/0ZfhhJ47fSe+gU7
         pa9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NEHWyKUy+A4yc/yn9c+viw8E0DL4Ftex3MlsHFwgTbw=;
        b=S76+ckszifumQCpM4Bo3UXGfSH0cm8t64YUg8HRorwfuIQmww3A8JrRncVfbX99Qza
         S/OGu72CgstGZQpDhWLLDAI9omOWni+51UA+ovs0XgEckI4v/h/JIpd2+M6jfC34VzsR
         9psIhLSx53ms9XksVUzScCUTZN0wHX321BOUJSQDgJacnfQ5+YhLLY3oWd1wmJK6SOzA
         RFcepHzI+8CForpOscxhQCTSxu8BNJDatMahTMpKwmMH16PSQ7s42KMdbZXtxqkrMCzQ
         AwioChwwx378rtaohDEC3cTqeqQzjgKWyOzl0s4NxumFyb67CCELADCJD234VnaPSn2a
         53VQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Liu Bo <bo.li.liu@oracle.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 4.14 146/195] Btrfs: raid56: iterate raid56 internal bio with bio_for_each_segment_all
Date: Thu, 15 Feb 2018 16:17:17 +0100
Message-Id: <20180215151713.140468440@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481780343747241?=
X-GMAIL-MSGID: =?utf-8?q?1592481780343747241?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liu Bo <bo.li.liu@oracle.com>

commit 0198e5b707cfeb5defbd1b71b1ec6e71580d7db9 upstream.

Bio iterated by set_bio_pages_uptodate() is raid56 internal one, so it
will never be a BIO_CLONED bio, and since this is called by end_io
functions, bio->bi_iter.bi_size is zero, we mustn't use
bio_for_each_segment() as that is a no-op if bi_size is zero.

Fixes: 6592e58c6b68e61f003a01ba29a3716e7e2e9484 ("Btrfs: fix write corruption due to bio cloning on raid5/6")
Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/raid56.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1432,14 +1432,13 @@ static int fail_bio_stripe(struct btrfs_
  */
 static void set_bio_pages_uptodate(struct bio *bio)
 {
-	struct bio_vec bvec;
-	struct bvec_iter iter;
+	struct bio_vec *bvec;
+	int i;
 
-	if (bio_flagged(bio, BIO_CLONED))
-		bio->bi_iter = btrfs_io_bio(bio)->iter;
+	ASSERT(!bio_flagged(bio, BIO_CLONED));
 
-	bio_for_each_segment(bvec, bio, iter)
-		SetPageUptodate(bvec.bv_page);
+	bio_for_each_segment_all(bvec, bio, i)
+		SetPageUptodate(bvec->bv_page);
 }
 
 /*
