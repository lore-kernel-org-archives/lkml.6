Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtJm0q8gNUXvS+zDZn3JnrbDAmvYr+U/0QoDC9y7ixIrDUq/66dxfjSmSCYjA11PnImJu0i
ARC-Seal: i=1; a=rsa-sha256; t=1521484287; cv=none;
        d=google.com; s=arc-20160816;
        b=QHS1vp0Jwp46uZjEWX46yh529jVU9goPBBvskXl2yAiPVvOYYXPfKJjVARHEXGW7g4
         Y3qHvYfvUuTo8T3zDgxP/W/LewjDv5VuER2upZGUag92TamfMs0KtdBKNLxqE3SxhwRg
         X6hEcyiq0+ducL10THd7fFYG+EsavPUJxke1tGHYKhcFzDLHS+II/bkjVLWyorLkpsKF
         33yS7+m87lJ0HJi4K+6XM3oPZUiKim1ZS2UYwY5Q6J5TJq06VptDazL2UWxqTUGNgx6Z
         CQRMdm1rUtche29ZTNioTAMLXqWNOI+9FB+VcPZjwN80N1iwZZ/MFtIp3Md6QIma6Lrr
         ZWDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ptAGrLRnxngeVnS6ga7Non7iv+cKneH6bAfqhXsldDs=;
        b=mk9V8Qfwh8oAXB+U7Pk+iYCeHjsbjkTaAY31d7w4UKOfcZZpVkQ5WWvZnNzh10bFsw
         8K03l1gEuqL5UQ1cu1aQNDsMfk9w04lGlAkHSxGucfGFFvVA3pdWvKgEyD4wgv4MJRbo
         p9Xz70FNn0QL/rOoBbwY8PBYqVYG4bLWg0z5qf43DIwGZNL1gZSVF5qsmltoztRKRJZe
         QA2+rWU50hYr6ONY6t/k008elF2CY8QqL18db+NsuTAJzGl7MqCADqBMwZ51LcxOFb1O
         CNHgzhNmMgiGkRHzS06XjoPGcBjEMaL1AM0vRaWMdC0ih9GGXNyxJM4xp6Urm8Lcws64
         X9OA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Pierre Moreau <pierre.morrow@free.fr>,
	Maris Nartiss <maris.nartiss@gmail.com>,
	Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 4.15 16/52] drm/nouveau/mmu: ALIGN_DOWN correct variable
Date: Mon, 19 Mar 2018 19:08:14 +0100
Message-Id: <20180319180736.052048591@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180734.976730813@linuxfoundation.org>
References: <20180319180734.976730813@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391908050995733?=
X-GMAIL-MSGID: =?utf-8?q?1595391908050995733?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Māris Nartišs <maris.nartiss@gmail.com>

commit da5e45e619b3f101420c38b3006a9ae4f3ad19b0 upstream.

Commit 7110c89bb8852ff8b0f88ce05b332b3fe22bd11e ("mmu: swap out round
for ALIGN") replaced two calls to round/rounddown with ALIGN/ALIGN_DOWN,
but erroneously applied ALIGN_DOWN to a different variable (addr) and left
intended variable (tail) not rounded/ALIGNed.

As a result screen corruption, X lockups are observable. An example of kernel
log of affected system with NV98 card where it was bisected:

nouveau 0000:01:00.0: gr: TRAP_M2MF 00000002 [IN]
nouveau 0000:01:00.0: gr: TRAP_M2MF 00320951 400007c0 00000000 04000000
nouveau 0000:01:00.0: gr: 00200000 [] ch 1 [000fbbe000 DRM] subc 4 class 5039
mthd 0100 data 00000000
nouveau 0000:01:00.0: fb: trapped read at 0040000000 on channel 1
[0fbbe000 DRM]
engine 00 [PGRAPH] client 03 [DISPATCH] subclient 04 [M2M_IN] reason 00000006
[NULL_DMAOBJ]

Fixes bug 105173 ("[MCP79][Regression] Unhandled NULL pointer dereference in
nvkm_object_unmap since kernel 4.15")
https://bugs.freedesktop.org/show_bug.cgi?id=105173

Fixes: 7110c89bb885 ("mmu: swap out round for ALIGN ")
Tested-by: Pierre Moreau <pierre.morrow@free.fr>
Reviewed-by: Pierre Moreau <pierre.morrow@free.fr>
Signed-off-by: Maris Nartiss <maris.nartiss@gmail.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Cc: stable@vger.kernel.org # v4.15+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
@@ -1354,7 +1354,7 @@ nvkm_vmm_get_locked(struct nvkm_vmm *vmm
 
 		tail = this->addr + this->size;
 		if (vmm->func->page_block && next && next->page != p)
-			tail = ALIGN_DOWN(addr, vmm->func->page_block);
+			tail = ALIGN_DOWN(tail, vmm->func->page_block);
 
 		if (addr <= tail && tail - addr >= size) {
 			rb_erase(&this->tree, &vmm->free);
