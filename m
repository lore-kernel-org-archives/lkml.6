Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx489sWItuJF6JjvHYm6nbB6CA34GEjkaG8aaxmRhRNpQwYNWvfhzV+Ihyz/EUHQROunZ/2tw
ARC-Seal: i=1; a=rsa-sha256; t=1523981093; cv=none;
        d=google.com; s=arc-20160816;
        b=KEp1W7/c/jdj738VR/z8RVprmr71mzASf7PkoHWLQUBHlVxL3VF2TefWYrEaqcfeFU
         sTnkzzMGIvUZity408Tcq4dHrTj3fVPKJTm7gr39sA9qZTzLokwqJcLstYmNEQxN3T7r
         5z/ljjgJUBGUlmveqXziNIvBqpTA1NPd6l/kDT6V8sgKvitLikQpXMSdYl53ZqzERe9N
         z3/0AswLb6zh+2XnQFk620l4gLR8IPMc6RjrytIonf51Z7Sb5VpoUaOY8f7nBrWsLyTO
         fuDN7eTMnVA47Ydk36ikQw/odvToCs8MXM2g+TR+haGyJ/nmurfVdpiTmJVHX/Q95cUi
         ScjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=eBSAXKYAUYh8s8jTzuhc7lnle/Gs3YJQMcu1i9RjWTk=;
        b=gWutGLIc5cI6PKSzdxg7qKcVkMyBhFabP1jyZL1iOuNuCnEU61n2FAZetIyTx+XX7c
         1+z/bxtnJ2wszn7QSzjNybRex0DnkDSHR4+wFS5bLoj0MGJpoyUQWurlLUwMOQjM+C2q
         nCelcw54znJpHRtmJiCIN1sX7tn+lawJDpYSy+me9byBmNLIJFTuVmyNHj8its8EzWck
         xzkY3VXfHgIBmiKJjUvYPlFffC82tgUSrJFMEJkFQ8u+9WS4a6hJ2SSl0VajpqChtOkq
         OrxH+pPy5ayAJs3JOyLxSOTqrURdsZYuOYAVstEMysQ7BeOE2adhNgKbadyYVlgl+4Z5
         d6xQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Auger <eric.auger@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 10/53] vhost: Fix vhost_copy_to_user()
Date: Tue, 17 Apr 2018 17:58:35 +0200
Message-Id: <20180417155723.662183823@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009751810796107?=
X-GMAIL-MSGID: =?utf-8?q?1598009999959860649?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Auger <eric.auger@redhat.com>


[ Upstream commit 7ced6c98c7ab7a1f6743931e28671b833af79b1e ]

vhost_copy_to_user is used to copy vring used elements to userspace.
We should use VHOST_ADDR_USED instead of VHOST_ADDR_DESC.

Fixes: f88949138058 ("vhost: introduce O(1) vq metadata cache")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vhost/vhost.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -756,7 +756,7 @@ static int vhost_copy_to_user(struct vho
 		struct iov_iter t;
 		void __user *uaddr = vhost_vq_meta_fetch(vq,
 				     (u64)(uintptr_t)to, size,
-				     VHOST_ADDR_DESC);
+				     VHOST_ADDR_USED);
 
 		if (uaddr)
 			return __copy_to_user(uaddr, from, size);
