Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqF8h+C7wBnvRG4rxzjXORSP5hicSRdx6C4mf/LI+A7sfMB63lSaSrsnOq0rPCtapNFXFrX
ARC-Seal: i=1; a=rsa-sha256; t=1524838301; cv=none;
        d=google.com; s=arc-20160816;
        b=bZiCEr4ZKKeKGeHB033YwUTuLmank+mIJdjzj1+VNFwMLK/eykDJJtinJfKx5ZscMO
         g22qvwL+AOSmjybXv6Y8WCSBBTWeueAiVwPDobyjwed2i4BU6IfpcSHLkymKUEgoTRVn
         uEn62pgJSRik0jQmT64IVqoT964Bp7SuLtPfTYnPOwYVNdlrm75q9jYZ5PM7TY+uaGTo
         vvMsZ9fo9zN9zr/zKTRRN6PgHFZuFA17Y3i7ePq54aFM99+DAx4crqvfj8a/SIFXhYzA
         nIjorHUc9aRcmYhHXBjaywXDPbM1qFux56aCZHOoREcNagAU9W9ATHfWA4rIM82yfQQG
         OM7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=Z6McPc9kflWCggidt5K9wA+2OC2rwNv771RrmIGDbgA=;
        b=HE3sRC772LQmTQbt5iZgimG2hS+KPjK+MbsGysKHUw3UuN3WpKkOvU1bkAwnb6U6e5
         TxA0jaZ9GIsAbLnrDcD2Ey33R4rWrFVSmlbRN6loEoqFP+Ticj76cTT9HCR8IgqLUX4v
         xVdisxOLlLcKRyyPnHP+yQc53sujkgzGjRpQesKexXSla36uOti0xYjcCOVGJaj4P3n3
         8IFhuvycIUXby4Dj3IzPMFCfmc0U7DsizSOAIPmZQt1qityabJwSi8fpsnggqMSplTHW
         Jh+43NyY59bM+Eer/Pvk3/N8LbQHgpyCRlfFU/uzdyvpLIVVNohgOsVl/XyzBQY3GlsC
         AejQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFF221897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xiumei Mu <xmu@redhat.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jorgen Hansen <jhansen@vmware.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 54/81] VSOCK: make af_vsock.ko removable again
Date: Fri, 27 Apr 2018 15:58:56 +0200
Message-Id: <20180427135746.445847070@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908847534033819?=
X-GMAIL-MSGID: =?utf-8?q?1598908847534033819?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Hajnoczi <stefanha@redhat.com>


[ Upstream commit 05e489b1596f0aa1025a1fa572676631cd9665da ]

Commit c1eef220c1760762753b602c382127bfccee226d ("vsock: always call
vsock_init_tables()") introduced a module_init() function without a
corresponding module_exit() function.

Modules with an init function can only be removed if they also have an
exit function.  Therefore the vsock module was considered "permanent"
and could not be removed.

This patch adds an empty module_exit() function so that "rmmod vsock"
works.  No explicit cleanup is required because:

1. Transports call vsock_core_exit() upon exit and cannot be removed
   while sockets are still alive.
2. vsock_diag.ko does not perform any action that requires cleanup by
   vsock.ko.

Fixes: c1eef220c176 ("vsock: always call vsock_init_tables()")
Reported-by: Xiumei Mu <xmu@redhat.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jorgen Hansen <jhansen@vmware.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Jorgen Hansen <jhansen@vmware.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/vmw_vsock/af_vsock.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2018,7 +2018,13 @@ const struct vsock_transport *vsock_core
 }
 EXPORT_SYMBOL_GPL(vsock_core_get_transport);
 
+static void __exit vsock_exit(void)
+{
+	/* Do nothing.  This function makes this module removable. */
+}
+
 module_init(vsock_init_tables);
+module_exit(vsock_exit);
 
 MODULE_AUTHOR("VMware, Inc.");
 MODULE_DESCRIPTION("VMware Virtual Socket Family");
