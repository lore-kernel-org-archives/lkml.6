Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49/eNeBLEohf9XxQ27aZKyXqGSF8h90/C3XqQaQsZiRhyVX2OhYojZm7IYpwWrafnh5lLWI
ARC-Seal: i=1; a=rsa-sha256; t=1523473264; cv=none;
        d=google.com; s=arc-20160816;
        b=OG1MOPg+MqwEyXxuJ3+qeC5ovZGHoay+baj5aanoPghhJCZZpM9dV26wNJL3u+r/bk
         6nPmmJDUodZvsf9hNeWeJ2xD2/0NbIkDhZE2kRA2B0fnUIbcTsWgmqMnU5fNOd6vjbch
         cDF8XU9Eod9HWZ8vG58LVPXGYJXDVsJJjFonhkpLFAkQwcfC4NDed0VopKtaj36fra1p
         SKD485FVBNfvzaQEb1hj+KNkD3ytq9hjCHAs9RRVFt7uAy6o/dsh/ouvtVAAyVaLHkvL
         9sujnYvqoe3daipUbJqCCwSQO85HhNCKEQPE/xcDVoywaydljibd7+oXpE6q7tF1o1Dn
         BNlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ioFQAf+E6XYzZQOvhNnS0iB0AyPmVjRsYLMoynVCbXE=;
        b=VhSWYt1JBHoXzAcb6YJfbhyV6Ml0erQ8YM7ye7iummQ0ilpOp3gS3CnG4PKjq1o2xS
         AkJq3OcCvnr1QR2Y6Cg8mGzIw4RQNQ2zKQSnm86I1KZzmE5v4Zl8/lYBfFn4GCKura3K
         vSkusJtz+RHmwYafzr5Y8SiATS10Jel+EWwWsSANC+vO0mtBh5M+0w0gvQZ/4p1KwaSm
         cjVMyzYuIwkf8/f2ZrRJzEK6d5WWGr40gDBc2Lu93pYsko77yYdxesNT81vwH9joTnFl
         okn8BpbQ+EBqPhxY7zX3DsO2ZqFeOfhm3pT4pdup2jTCt1JG7z9f9SSIJfovVgTHuoo3
         11gg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christophe Leroy <christophe.leroy@c-s.fr>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 185/310] powerpc/8xx: fix mpc8xx_get_irq() return on no irq
Date: Wed, 11 Apr 2018 20:35:24 +0200
Message-Id: <20180411183630.571149557@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477501561437857?=
X-GMAIL-MSGID: =?utf-8?q?1597477501561437857?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@c-s.fr>


[ Upstream commit 3c29b6038828c1f4c9ecbfec14d4fc5e25f1c947 ]

IRQ 0 is a valid HW interrupt. So get_irq() shall return 0 when
there is no irq, instead of returning irq_linear_revmap(... ,0)

Fixes: f2a0bd3753dad ("[POWERPC] 8xx: powerpc port of core CPM PIC")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/sysdev/mpc8xx_pic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/sysdev/mpc8xx_pic.c
+++ b/arch/powerpc/sysdev/mpc8xx_pic.c
@@ -79,7 +79,7 @@ unsigned int mpc8xx_get_irq(void)
 	irq = in_be32(&siu_reg->sc_sivec) >> 26;
 
 	if (irq == PIC_VEC_SPURRIOUS)
-		irq = 0;
+		return 0;
 
         return irq_linear_revmap(mpc8xx_pic_host, irq);
 
