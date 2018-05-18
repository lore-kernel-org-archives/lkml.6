Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp6Z9S3PTlLS4nV3WU29hDJhKdNFVz+jzSk9G4+j40DQxVRw1ERiMhtuPjpf8sjsS0iE7hU
ARC-Seal: i=1; a=rsa-sha256; t=1526631578; cv=none;
        d=google.com; s=arc-20160816;
        b=mnXq8wHfMJPXKbArY9FmCiM8jMKpetcFFwtnzXj8W7lcIbWQsRzvuhBn+PvYFWjTEa
         kVMcVPVoJlkqit/1TpnwwWjbEGuuk6MfooAgSkyg/i2BCm9oPzzxMC81BZ9Cx3WP3uT2
         HxOyvq3YHdbkVM7cR25z5ysxbRQu9yXUW8iIqQUdVp+2pvVaui7cv8MMWqkGrz9FIwMr
         VxQLFz74HRRtaLbvvine5wn7F+1nL6CbAm/v82UjNv1NnLo/D1w0gZxjTmDm7Y3ob9yP
         vnSSlhXNpcX37e1fJwJ4x8ir4fjE8R+VyjjWg2SC/eWG55dKQQvmogPjvyVQuyVpLdh0
         QzDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=mfi1xo+vGmZi2Yp2krJ6ZDKXxtkfLtJmm91np+b1aFQ=;
        b=IcP/1GWOjlKNAn72IEHszZzSbjhQAuyjYNQPqMkww4eHh/wIc2deKy9liaHHN1PHBM
         TMqXYpkwI3jP9cWB/Pl+q15aRpspYDV4P2WxcR8tTGS/aSefQYdDSRUi3oCK7hAtbq/S
         BKNvk3XHDFRkUJaJ49xmx6pz9whR7JxVFvK+Dth92LSttjjjMZfAq9CMaUyL0R5AkrnQ
         DpfARt0x3oepBymE+VgHd5bue2TvLbrF8QXJoyGs+5SFOa3Om1e0LUq5/SZHBfT3C3/6
         Xd3TcGCgZ3JAHuDRAMudkt8VO42tHNRCKLJfrpzxBnlttcZp9Ls89DhLKciUv3ocA2bn
         yzng==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=MgFB91mV;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=MgFB91mV;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andre Tomt <andre@tomt.net>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 17/45] net/tls: Fix connection stall on partial tls record
Date: Fri, 18 May 2018 10:15:34 +0200
Message-Id: <20180518081531.206310972@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789178768699679?=
X-GMAIL-MSGID: =?utf-8?q?1600789234583187270?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andre Tomt <andre@tomt.net>

[ Upstream commit 080324c36ade319f57e505633ab54f6f53289b45 ]

In the case of writing a partial tls record we forgot to clear the
ctx->in_tcp_sendpages flag, causing some connections to stall.

Fixes: c212d2c7fc47 ("net/tls: Don't recursively call push_record during tls_write_space callbacks")
Signed-off-by: Andre Tomt <andre@tomt.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tls/tls_main.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -108,6 +108,7 @@ retry:
 			offset -= sg->offset;
 			ctx->partially_sent_offset = offset;
 			ctx->partially_sent_record = (void *)sg;
+			ctx->in_tcp_sendpages = false;
 			return ret;
 		}
 
