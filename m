Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt4vLZwDGtKTDViVU1LVmJIAe0Qspx/XniMZxb+iQr9yjD8xIsTKHeqRjv41jt8CK/34f1i
ARC-Seal: i=1; a=rsa-sha256; t=1521799888; cv=none;
        d=google.com; s=arc-20160816;
        b=KUsRL00zmkpDdtwhby+9Ogep5qUGKqfDHso97Bj3AdaT7AaYJBAc+KTfVOBdGyGp84
         OJjGm4cnfi5fLzDD62Z36g/WArAjxjO+j15EHGJ2P0uE9bjL270xiXc2tJ4NNm7N+jn0
         FODtDkO33dLzuNaxk+DtzBUadL67BOe1IJdsfy9Bhu0vPqmo8nQ90kRv1q1mu7CF4700
         B8ae1RcLV71Ri1sxmg2OadIYXnWDcyZT5aCG0GdJKtlIRtnxqXIUUicn6fdDGRDQHc71
         fFBsl/pv/kQBCmcjw+vfnpxAKlxhcmWvpwp2Aof2aFBm7+U4tFRBGmWdwH1KpkwK6d20
         ykjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zHJF1KcP/cCtXM28z8+08hdax+H4p6BFwhGkB7opdEo=;
        b=MVS26vmDJznDplgGd6cd2TO+WLwn7Rr+bW7A8i0jgq0r5GYxhsK5AHsHACitdoqKrn
         cltmw+2+k6MtdRPpuqp0xU1pV0DcST6LZrPUBjl2w4/pk2pctU7yRNdpHjHhpjRAGEwP
         vCbrg9/gkl6k7shmLdxSV9wATyzQQF6oyawOtfwlrf3aCK70RFimJbIEd9rRL/sPKAYS
         GdDcU7zy3saC7ZcAWs8+NJNKbhRsKmVJp0ol76o23PiXejU9v4rlCm/OdHt4iqFi1y4s
         rLMx1dHmHHEVAoIK+xGcTlt6r23lm04bUQ7w6FzILpJsKYZAA3n90tFxZxQOm56IHELg
         gRhw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 143/177] qmi_wwan: set FLAG_SEND_ZLP to avoid network initiated disconnect
Date: Fri, 23 Mar 2018 10:54:31 +0100
Message-Id: <20180323094211.513118106@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595721946694563316?=
X-GMAIL-MSGID: =?utf-8?q?1595722839610341117?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Bjørn Mork" <bjorn@mork.no>


[ Upstream commit 245d21190aec547c0de64f70c0e6de871c185a24 ]

It has been reported that the dummy byte we add to avoid
ZLPs can be forwarded by the modem to the PGW/GGSN, and that
some operators will drop the connection if this happens.

In theory, QMI devices are based on CDC ECM and should as such
both support ZLPs and silently ignore the dummy byte.  The latter
assumption failed.  Let's test out the first.

Signed-off-by: BjÃ¸rn Mork <bjorn@mork.no>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/qmi_wwan.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -531,7 +531,7 @@ err:
 
 static const struct driver_info	qmi_wwan_info = {
 	.description	= "WWAN/QMI device",
-	.flags		= FLAG_WWAN,
+	.flags		= FLAG_WWAN | FLAG_SEND_ZLP,
 	.bind		= qmi_wwan_bind,
 	.unbind		= qmi_wwan_unbind,
 	.manage_power	= qmi_wwan_manage_power,
@@ -540,7 +540,7 @@ static const struct driver_info	qmi_wwan
 
 static const struct driver_info	qmi_wwan_info_quirk_dtr = {
 	.description	= "WWAN/QMI device",
-	.flags		= FLAG_WWAN,
+	.flags		= FLAG_WWAN | FLAG_SEND_ZLP,
 	.bind		= qmi_wwan_bind,
 	.unbind		= qmi_wwan_unbind,
 	.manage_power	= qmi_wwan_manage_power,
