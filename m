Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932460AbeB1Opv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:45:51 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:20144 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932251AbeB1Opu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:45:50 -0500
X-RZG-AUTH: :L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySf+VvAflxJtId4Uwmx97D
X-RZG-CLASS-ID: mo00
Subject: Re: Build regressions/improvements in v4.16-rc3
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@ozlabs.org>
References: <1519817278-30770-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdVEFXL6hXhBNya-9LjORrZnyJJPzoBNMrufAdPEBVhLtA@mail.gmail.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <51783a88-f15e-f604-8439-1711282e4462@xenosoft.de>
Date: Wed, 28 Feb 2018 15:39:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVEFXL6hXhBNya-9LjORrZnyJJPzoBNMrufAdPEBVhLtA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

The following patch should be in the commit 'kvm-ppc-next-4.16-2' [1]:

Fixes: accb757d798c ("KVM: Move vcpu_load to arch-specific 
kvm_arch_vcpu_ioctl_run")
Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
arch/powerpc/kvm/powerpc.c | 2 ++
1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 403e642c78f5..0083142c2f84 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1608,7 +1608,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, 
struct kvm_run *run)

kvm_sigset_deactivate(vcpu);

+#ifdef CONFIG_ALTIVEC
out:
+#endif
vcpu_put(vcpu);
return r;
}
-- 
2.11.0

Unfortunately I haven't found this patch in the 'kvm-ppc-next-4.16-2' [1]

@Paul
Could you please add this fix?

Thanks,
Christian

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v4.16-rc3&id=1ab03c072feb579c9fd116de25be2b211e6bff6a


On 28 February 2018 at 12:29PM, Geert Uytterhoeven wrote:
> On Wed, Feb 28, 2018 at 12:27 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> JFYI, when comparing v4.16-rc3[1] to v4.16-rc2[3], the summaries are:
>>    - build errors: +1/-16
>    + /home/kisskb/slave/src/arch/powerpc/kvm/powerpc.c: error: label
> 'out' defined but not used [-Werror=unused-label]:  => 1611:1
>
> ppc64_defconfig+NO_ALTIVEC
>
>> [1] http://kisskb.ellerman.id.au/kisskb/head/4a3928c6f8a53fa1aed28ccba227742486e8ddcb/ (268 out of 274 configs)
>> [3] http://kisskb.ellerman.id.au/kisskb/head/91ab883eb21325ad80f3473633f794c78ac87f51/ (all 274 configs)
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
>
