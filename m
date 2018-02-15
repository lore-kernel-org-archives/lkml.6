Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225m6WbHejNWp2RT21oMSBv7uWExL5GzBhvBntT3yqRtypVZn3XSCyjFg0iBYIrIYCWVl2uv
ARC-Seal: i=1; a=rsa-sha256; t=1518708392; cv=none;
        d=google.com; s=arc-20160816;
        b=LPgqHJt9fSnigoPaQzJhE0QbzXsGfLKZUnEpENj4waORlS1J2rGyYUv1ghTflrDtlU
         t+ZO8sj/h4H6X+RjDKTUHRucnQ8Egct/M4EwFigJIUHzTqytofSbaVEezCz7nPxW07hh
         X22XAJeBIqtNuf2Wpml6AF8vIvbZ2FC72zZQmU8Q6HXb8cxgggmnVIqYRm2ruzze7Dxz
         TDised/XKSanDGOoS5gj602co2ll4Elz8bHb4RPns/s8wpcVcJOyR5VeeidZW+OHNgs/
         0SXQ1v9J9hfkSAkuz+esGIX0MPN3tZz0XRtumzVSU8QIx1Xa8oL3Y8RyZeaALTByt4LE
         lMaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=iiPOn78lI/CzcMEBgEIOgfaiX24aXWjU6EIyPcv+Eqk=;
        b=z+4WDwUA2dM2nR3AJm6LfUb1YOxegUjTZ95KK7ASqQxhf+GH9smmei0Tr++sHjpNoL
         6OMhECc3T+4lFMbJNsdB2jdp9qvgLJg5cG57RYOXn3ptZ0L4hFi3c43CuWqYUJEirSpP
         Qy/uqX6Bd7mB72krg1ENXsLz03tgR3BD2ZlVQbYGctSNsIYNg0gknAXYu18TP+ILRri2
         Xp0xKBW2cjVhiApL6hJtRTi1xmDV/B22js2J3f7XrQSSdBIHQ0p08KSQS44LpcECKJCB
         QiWqQwnFy4rpPpAIOzLNDvY4w+wecAglCXSGpo4OQEoKwgpaSzk92Ead7OXjTkdfRNhd
         Y2vA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Ivan Vecera <ivecera@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.9 27/88] kernfs: fix regression in kernfs_fop_write caused by wrong type
Date: Thu, 15 Feb 2018 16:16:54 +0100
Message-Id: <20180215151226.418654572@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480732716912474?=
X-GMAIL-MSGID: =?utf-8?q?1592481171165295925?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Vecera <ivecera@redhat.com>

commit ba87977a49913129962af8ac35b0e13e0fa4382d upstream.

Commit b7ce40cff0b9 ("kernfs: cache atomic_write_len in
kernfs_open_file") changes type of local variable 'len' from ssize_t
to size_t. This change caused that the *ppos value is updated also
when the previous write callback failed.

Mentioned snippet:
...
len = ops->write(...); <- return value can be negative
...
if (len > 0)           <- true here in this case
        *ppos += len;
...

Fixes: b7ce40cff0b9 ("kernfs: cache atomic_write_len in kernfs_open_file")
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/kernfs/file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -275,7 +275,7 @@ static ssize_t kernfs_fop_write(struct f
 {
 	struct kernfs_open_file *of = kernfs_of(file);
 	const struct kernfs_ops *ops;
-	size_t len;
+	ssize_t len;
 	char *buf;
 
 	if (of->atomic_write_len) {
