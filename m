Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+CLLxq+g4lrn8Sq/1/ZX2G8bTnZI22H5WI409/BbCWNKtZ+8ohiOoQuFx3YDMOduL9AzYl
ARC-Seal: i=1; a=rsa-sha256; t=1522168717; cv=none;
        d=google.com; s=arc-20160816;
        b=mif5TevM9ZWpRLe1zW1LcOoib/NMM0jXXYFPdmLwJoVlqRYd+EvknUAUm1zJDP8yOG
         ifePUVAGrrpiUIS9qdiJvG+PdYeZkMtVu+3Xx0l1lFP4irPxWD62sRfwlCSVnQIpQjh/
         Re0zUnfsyMSunNZK+gOjV8tIkHr1op0h39W9c4kCJhUoxChLH/EEvN1SD98bvl8Lee+h
         fQXEf1KlfOFosbGsEHOwrPQbENWHoQs/KcYKeasEHdqSYk0RBv8FjNNdzJ8Lmm9YxJRZ
         eJfo9tqN3Gvw/37EEjOsAtoB0FIkPWYL5S17hTdDsFRwt4IxPD8HDUO+kidL4WFbZazf
         Bf0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KKjiJUj21glv+nARWX5GWQWgfdnE9G7vRIYEYzPJ1so=;
        b=xRdnoxKCTUFdqyTBQn70d9f31mTA903Z//r7504pZx0zQt3P14kWK7ODYmda/6yy0E
         FCPrhuaTN0MeZDICDhPFYE7Dt7Nfhd8LGEuqPpICrutSCw46sMvyq8+ilCB1Qfy1FPBZ
         MW7aHpqcrwDa0J8lpRjAJfPRcb9iu1V5N/GxL3yBdDPPv4X12efIB7YSKjB4p6Zsb2E1
         Nsk3Z4yPlxRi9wXVLptOpVBWDo2DFDE7VqMfMrQulkKxr0Os0JLd1qzA33+M5ri55wny
         /YFkkTX+bjKaQTNo8440jcT+3FF8i7WYNksuIgMNA2JJXaw2giET+arr728kVXRpzsAX
         6Suw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH 4.14 101/101] bpf, x64: increase number of passes
Date: Tue, 27 Mar 2018 18:28:13 +0200
Message-Id: <20180327162756.184401630@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109079875177032?=
X-GMAIL-MSGID: =?utf-8?q?1596109585163804493?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

commit 6007b080d2e2adb7af22bf29165f0594ea12b34c upstream.

In Cilium some of the main programs we run today are hitting 9 passes
on x64's JIT compiler, and we've had cases already where we surpassed
the limit where the JIT then punts the program to the interpreter
instead, leading to insertion failures due to CONFIG_BPF_JIT_ALWAYS_ON
or insertion failures due to the prog array owner being JITed but the
program to insert not (both must have the same JITed/non-JITed property).

One concrete case the program image shrunk from 12,767 bytes down to
10,288 bytes where the image converged after 16 steps. I've measured
that this took 340us in the JIT until it converges on my i7-6600U. Thus,
increase the original limit we had from day one where the JIT covered
cBPF only back then before we run into the case (as similar with the
complexity limit) where we trip over this and hit program rejections.
Also add a cond_resched() into the compilation loop, the JIT process
runs without any locks and may sleep anyway.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/net/bpf_jit_comp.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1156,7 +1156,7 @@ struct bpf_prog *bpf_int_jit_compile(str
 	 * may converge on the last pass. In such case do one more
 	 * pass to emit the final image
 	 */
-	for (pass = 0; pass < 10 || image; pass++) {
+	for (pass = 0; pass < 20 || image; pass++) {
 		proglen = do_jit(prog, addrs, image, oldproglen, &ctx);
 		if (proglen <= 0) {
 			image = NULL;
@@ -1183,6 +1183,7 @@ struct bpf_prog *bpf_int_jit_compile(str
 			}
 		}
 		oldproglen = proglen;
+		cond_resched();
 	}
 
 	if (bpf_jit_enable > 1)
