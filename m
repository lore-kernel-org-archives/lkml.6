Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoerGC72NmYadIsFpfDvN8yBiKmINoqNI276nfJY2aM6nxwBMhRMParMLF1bVQzaSXJMQk1
ARC-Seal: i=1; a=rsa-sha256; t=1526937295; cv=none;
        d=google.com; s=arc-20160816;
        b=C+sO45uBxKbQaRtt6I/kQYOmfkjn0zOMMmISuYRG3zFqsa6mHxnP3j3+eyga6im3pT
         Chn5OWe6giqUatjn0s2VbnEE7bCfl4ZzXdkQ13KYnZemPhXVZIjDrxbu5kM/PXOehGIp
         HT8Vg9ZJgjJbUvJbn7wIvm+XHV/Z3Ycmx6ZFx8jYDLPqumZ+YXNbx4ev9xgU8kENwRVK
         XrLV1iYPK6CrjqrnVQ1O/2gqzZlxb3bf6fXZ2w422bshouoOLYEw+7ulJBfWv+Kuh/hu
         3yH/YiCvmEq7xrPeeVEb51k21LHU1BREJbSNd+wL41YFv8WGWT+N30ZC7DsK71q77A4L
         QjTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ofgo+5cHdRZ1x7hN4XRTo4G7L6h95kVJXCkINto1wjk=;
        b=qFk6Q5arQlA6dHjiQ+BgLUptLaawRojVaCmEITGws5X+TM79W3TtmlgjJDtPoEC8w8
         6HAJeetAiKSEdRMpYtfkQ9fU7A3glPycwGtkAwMlMrsY1Z9WZ+oo6CeQEqYh3Zyy2/NZ
         b2AIQrahlDV6pYKMudAp5pdfH0f8PCJ6S580FZbUoMiH7frB0Kdhch/ebuxOqfzlI7L7
         FryRBW1xs2uzRZac7WPaMp4KyvOSNOCCjhpH7OCacGJ0hcq7YWC81IUrFs3CiMbPo8r4
         xw0vr6E1Cp36un8jEuQJgX/pLZRcOnvKnB533g/QazjODdxgK/2r8qI+u4S/sdZee0y0
         8uiw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=fIY08ArI;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=fIY08ArI;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 4.9 30/87] ARM: 8770/1: kprobes: Prohibit probing on optimized_callback
Date: Mon, 21 May 2018 23:11:06 +0200
Message-Id: <20180521210423.134228297@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109801592715270?=
X-GMAIL-MSGID: =?utf-8?q?1601109801592715270?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 70948c05fdde0aac32f9667856a88725c192fa40 upstream.

Prohibit probing on optimized_callback() because
it is called from kprobes itself. If we put a kprobes
on it, that will cause a recursive call loop.
Mark it NOKPROBE_SYMBOL.

Fixes: 0dc016dbd820 ("ARM: kprobes: enable OPTPROBES for ARM 32")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/probes/kprobes/opt-arm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/probes/kprobes/opt-arm.c
+++ b/arch/arm/probes/kprobes/opt-arm.c
@@ -192,6 +192,7 @@ optimized_callback(struct optimized_kpro
 
 	local_irq_restore(flags);
 }
+NOKPROBE_SYMBOL(optimized_callback)
 
 int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *orig)
 {
