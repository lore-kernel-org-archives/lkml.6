Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx496i/BxAyf3Q+tS7c1mjMlLEx1mCCbv+D9nw9ajTyesZE0K+REI+UH1CKUG5GMbxbzd/Y/6
ARC-Seal: i=1; a=rsa-sha256; t=1524652821; cv=none;
        d=google.com; s=arc-20160816;
        b=ya4tOwerClwPD6Hmt5FhLUflfbFqFbE5x67+LiixbeWVfQC+hVN+FjGCh7xWJtKNuK
         TfdDQw0gyY2MXELOmDBNNpp9Fd2XiBLM9arNYryb/IaT6ZI0AdchtHuD7yft2wwAhbC0
         i3cTfiRiqYK+qxTJqY+N7UEKbTgpYoM4srHmgnCcCZyKIBj4HSPnLs+jPCuKiYoIO/pR
         gpA8P24Wu+IKWplBUbWCn/IXMCy23cjiRweb1VDdzxgtlm2wrVeO4TFksAyYT2bqnq0m
         xKFKTkwydhJ4zUTqkDOebLriX+G+BQoadMGr0Wiv0SRTiIyvqGdzs+MaGtRMP5JqLxib
         ep9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wWxHnoMAU5Eny5uRAKOAXf0SqQsU1ro4JBqAI79FGVg=;
        b=f3dnW/woVOH2C4VMr/hen5Td1L4OyGbjT4a7jvDYHcEbNmiXaLj/60R6yJ2/U2aO69
         X4qy++K037XEz5R4HT6uqva7AN1ml7y6s7zo839iPHDSuMJEtatpeBg0I7xAnIEu+4Xc
         o/7ufrsqTN5Q2vYl16yxJGJ392qm1LeQHBOf4hmFB3Iz7TsxX7CMSQ0QDXYCwd5Jyo/Z
         EfFkQwKL7hZSRgFVucwKHE+t5Sc3v0VGlVig3CDFtdNHhj5dPS/G81KNASSBFcMuFc57
         5TNr+clmgRQDkii73GBVfW8swBYvzHaN3cps/fqmI5tNn53dpQZoJfEfAb6+9nqy0mtx
         Fd4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Eryu Guan <eguan@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 082/183] blk-mq-debugfs: dont allow write on attributes with seq_operations set
Date: Wed, 25 Apr 2018 12:35:02 +0200
Message-Id: <20180425103245.800521498@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714357137018754?=
X-GMAIL-MSGID: =?utf-8?q?1598714357137018754?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eryu Guan <eguan@redhat.com>


[ Upstream commit 6b136a24b05c81a24e0b648a4bd938bcd0c4f69e ]

Attributes that only implement .seq_ops are read-only, any write to
them should be rejected. But currently kernel would crash when
writing to such debugfs entries, e.g.

chmod +w /sys/kernel/debug/block/<dev>/requeue_list
echo 0 > /sys/kernel/debug/block/<dev>/requeue_list
chmod -w /sys/kernel/debug/block/<dev>/requeue_list

Fix it by returning -EPERM in blk_mq_debugfs_write() when writing to
such attributes.

Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Eryu Guan <eguan@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-mq-debugfs.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -704,7 +704,11 @@ static ssize_t blk_mq_debugfs_write(stru
 	const struct blk_mq_debugfs_attr *attr = m->private;
 	void *data = d_inode(file->f_path.dentry->d_parent)->i_private;
 
-	if (!attr->write)
+	/*
+	 * Attributes that only implement .seq_ops are read-only and 'attr' is
+	 * the same with 'data' in this case.
+	 */
+	if (attr == data || !attr->write)
 		return -EPERM;
 
 	return attr->write(data, buf, count, ppos);
