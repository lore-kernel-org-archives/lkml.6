Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49XULrGYcX0Y5y66QO6FGpSTrcKpYom9xQqW40+q5/+pnRGePHsGt4Vl3rdGLU3GEoEcb7g
ARC-Seal: i=1; a=rsa-sha256; t=1522168235; cv=none;
        d=google.com; s=arc-20160816;
        b=BLZBaSVLKl4NruCfwo+a9NeVgT6XrhuGJ+qPOTL47n7/9z1Xm2dH2VxgYtXSlDrI3O
         MCfPLovi+KAX4P4u75r7r8atMAJkttsFxPtjhRIIwJqmd30RvFg1zTLJVuYmnvr8Hy6S
         cWaWjOBzyOqU/0F7KD0BgUnlcGcl8v72tbk3jDlvezw3bGP2G3qxTB1MywcBWFwS9p0e
         A4RGGLL5hzSGIZX9ZfDnsDFxsanVRJx3RGQgUMUsWq6uX+cLbUtU5IJStnPzB5DVNAl0
         R9/4mi1Uj/NHtEY4niuIL9Hyw+tjR2Gjz1L3H01fPrr80X+eEFMzESsdY5pFNCSA6HO5
         lYpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Y/rzNjvVKXMvGdkchoroqo6xHdc48QqlvGIPTsHErgg=;
        b=zlRx0S2fJiINfmDm8gT7aMEIb+ixnu0pN+wUwVsYb0bzR3TmNvm8ocj3iuOgh+FhzC
         WegT21uJpcOYuPLthfgszE1NPi4YyUeT2X8sdspXNSfJPF9JxjOzDOQCtQHyfbLP9EZg
         E0cqFNXX+8pZxnDnsMXT88yenTjTqyPPNIOskWp2ShH88Xe31isCpVqEwmEYT2mA3QDo
         rd57CltSXyRVV/PAtPXzHoHD9DakngfBHN9xgsmrhVuOi1yWSTxFBD1GK+SFKK9YfSEI
         C3+OD5IGEWMc957dY9ph7WK1PkIF7d7816H5Z1ci5YXqXzbdYMQaxBSrjEdEkJH5P9ag
         x30w==
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
Subject: [PATCH 4.4 43/43] bpf, x64: increase number of passes
Date: Tue, 27 Mar 2018 18:27:47 +0200
Message-Id: <20180327162718.802115307@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109079875177032?=
X-GMAIL-MSGID: =?utf-8?q?1596109079875177032?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1077,7 +1077,7 @@ void bpf_int_jit_compile(struct bpf_prog
 	 * may converge on the last pass. In such case do one more
 	 * pass to emit the final image
 	 */
-	for (pass = 0; pass < 10 || image; pass++) {
+	for (pass = 0; pass < 20 || image; pass++) {
 		proglen = do_jit(prog, addrs, image, oldproglen, &ctx);
 		if (proglen <= 0) {
 			image = NULL;
@@ -1100,6 +1100,7 @@ void bpf_int_jit_compile(struct bpf_prog
 				goto out;
 		}
 		oldproglen = proglen;
+		cond_resched();
 	}
 
 	if (bpf_jit_enable > 1)
