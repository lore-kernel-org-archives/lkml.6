Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64FEC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD100206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfAIQkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:40:51 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:47141 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbfAIQkp (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Wed, 9 Jan 2019 11:40:45 -0500
Received: from linux-l9pv.suse (124-11-22-254.static.tfn.net.tw [124.11.22.254])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Wed, 09 Jan 2019 17:40:29 +0100
Date:   Thu, 10 Jan 2019 00:39:58 +0800
From:   joeyli <jlee@suse.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 0/5 v2][RFC] Encryption and authentication for hibernate
 snapshot image
Message-ID: <20190109163958.GG9503@linux-l9pv.suse>
References: <20190103143227.9138-1-jlee@suse.com>
 <20190106181026.GA15256@amd>
 <20190107173743.GC4210@linux-l9pv.suse>
 <CALCETrWHjn_WN1WRc2pbFPB+H-ZL_1y=8dhhHoVqA53Q7Pj5vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrWHjn_WN1WRc2pbFPB+H-ZL_1y=8dhhHoVqA53Q7Pj5vA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thanks for your review!

On Tue, Jan 08, 2019 at 01:41:48PM -0800, Andy Lutomirski wrote:
> > On Jan 7, 2019, at 9:37 AM, joeyli <jlee@suse.com> wrote:
> >
> > Hi Pavel,
> >
> > Thanks for your review!
> >
> >> On Sun, Jan 06, 2019 at 07:10:27PM +0100, Pavel Machek wrote:
> >> Hi!
> >>
> >>> This patchset is the implementation of encryption and authentication
> >>> for hibernate snapshot image. The image will be encrypted by AES and
> >>> authenticated by HMAC.
> >>
> >> Ok, so you encrypt.
> >
> > Yes, encryption and authentication.
> >
> >>> The hibernate function can be used to snapshot memory pages to an image,
> >>> then kernel restores the image to memory space in a appropriate time.
> >>> There have secrets in snapshot image and cracker may modifies it for
> >>> hacking system. Encryption and authentication of snapshot image can protect
> >>> the system.
> >>>
> >>> Hibernate function requests the master key through key retention service.
> >>> The snapshot master key can be a trusted key or a user defined key. The
> >>> name of snapshot master key is fixed to "swsusp-kmk". User should loads
> >>> swsusp-kmk to kernel by keyctl tool before the hibernation resume.
> >>> e.g. The swsusp-kmk must be loaded before systemd-hibernate-resume
> >>
> >> But if userspace has a key, encryption is useless against root.
> >
> > Yes, but this concern is not only for hibernation encryption. This patch
> > set does not provide solution against this concern.
> >
> > The purpose of this patch set is to encrypt and authenticate hibernate
> > snapshot image in kernel space. It also requests key through keyring
> > mechanism. Which means that we can easy to adapt to new key type from
> > keyring in the future.
> >
> > Currently TPM trusted key or user defined key types are not against
> > root. Even using the TPM trusted key, it still can be unsealed by root
> > before the PCRs be capped (unless we capped PCRs in kernel).
> >
> > My solution for keeping the secret by kernel is the EFI secure key type:
> >    https://lkml.org/lkml/2018/8/5/31
> >
> > But the EFI boot variable doesn't design for keeping secret, so Windows
> > and OEM/ODM do not use boot variable to keep secret. So this idea can
> > not be accepted. We must think other key type against root.
> >
> >>> The TPM trusted key type is preferred to be the master key. But user
> >>> defined key can also be used for testing or when the platform doesn't
> >>> have TPM. User must be aware that the security of user key relies on
> >>> user space. If the root account be compromised, then the user key will
> >>> easy to be grabbed.
> >>
> >> In the TPM case, does userland have access to the key?
> >
> > In the TPM case, userland can only touch the sealed key blob. So userland
> > doesn't know the real secret. But it has risk that root unseals the key
> > before PCRs be capped.
> >
> >> Please explain your security goals.
> >
> > My security goals:
> >
> > - Encrypt and authicate hibernate snapshot image in kernel space. Userspace
> >  can only touch an encrypted and signed snapshot image.
> 
> Signed?
> 
> I’m not entirely convinced that the keyring mechanism is what you
> want. ISTM that there are two goals here:
> 
> a) Encryption: it should be as hard as can reasonably be arranged to
> extract secrets from a hibernation image.
>
> b) Authentication part 1: it should not be possible for someone in
> possession of a turned-off machine to tamper with the hibernation
> image such that the image, when booted, will leak its secrets. This
> should protect against attackers who don’t know the encryption key.
> 
> c) Authentication part 2: it should be to verify, to the extent
> practical, that the image came from the same machine and was really
> created using hibernation.  Or maybe by the same user.
> 
> For (a) and (b), using an AE mode where the key is protected in some
> reasonable way.  Joey, why are you using HMAC?  Please tell me you’re
> at least doing encrypt-then-MAC.  But why not use a real AE mode like
> AES-GCM?

The reason for using HMAC is the history for development. My first patch
set is only for hibernate authentication. Then I added encryption code on
top of my authentication patches in last version.

I am doing encrypt-then-MAC. My code ecrypts each page by AES then HMAC
whole snapshot image. I feed encrypted data pages one by one to
crypto_shash_update() API for calculating the hash for whole image. 

Because kernel marks non-continuous free pages as a big buffer for
produce/restore hibernate snapshot image. For convenience, I hope that
the size of encrypted page will not be increased. One date page is still
one page after encrypted. It's good for saving limited free pages to
avoid the hibernation failed.

Let's why I encrypt/decrypt data pages one by one, then I copy the
encrypt/decrypt data from buffer page (only one buffer page reserved
for encrypt/decrypt) to original page. I encreypt pages one by one, but
I HMAC and verify the whole snapshot image by update mode.

My target is to create an encrypted/signed snapshot image before the
image be exposed by kernel to userspace or swap.

> 
> 
> I reviewed the code a bit.  Here are some thoughts:
> 
> You have some really weird crypto. You’re using an insanely long key
> (512 bits, I think, although you’ve used some bizarre indirection).

Is the key too long for SHA512? I keep that the key size equals to
the digest size because the HMAC spec rfc2104 suggests:

   ............................ We denote by B the byte-length of such
   blocks (B=64 for all the above mentioned examples of hash functions),
   and by L the byte-length of hash outputs (L=16 for MD5, L=20 for
   SHA-1).  
   ...
   The key for HMAC can be of any length (keys longer than B bytes are
   first hashed using H).  However, less than L bytes is strongly
   discouraged as it would decrease the security strength of the
   function.  Keys longer than L bytes are acceptable but the extra
   length would not significantly increase the function strength. (A
   longer key may be advisable if the randomness of the key is
   considered weak.)

The L is the byte-length of hash output. I use SHA512 so I set the
key size to 64 bytes = 512 bits

> You’re explicitly checking that it’s not zero, and I don’t see why.
>

That's because I use trampoline page to forward the key from boot
kernel to resume kernel for next hibernation cycle. When resuming,
the empty key means that the boot kernel didn't forward valid key
to resume kernel. Then the key initial failed, hibernation can not
be triggered in next cycle.

I will explain why setting trampoline page at below. 
 
> Why are you manually supporting three different key types?  Can’t you
> just somehow support all key types?  And shouldn’t you be verifying

I only supported two key typs in my patch set, user defined key and
TPM trusted key. The EFI secure boot did not accept by EFI subsystem.
So I didn't support it in this version.

Different key type has different structure. So we need different
handler for extracting the key data from key structure. It's impossible
to support all key types in one code because it's can be arbitrary
defined. For example, we can defined our own user defined key for
specific subsystem or driver, we just need a special handler to handle
it in driver.

> the acceptable usage of trusted keys?
>

Sorry for I didn't capture the meaning of "acceptable usage". The trusted
key already be unsealed by TPM when the key be enrolled by keyctl tool.
So my code just extract the unsealed key data (the random number) for
encryption.
 
> You are using a non-ephemeral key and generating a fresh IV each time.
> This is probably okay, but it’s needlessly fragile. Just generate an
> entirely fresh key each time, please.  You also seem to be doing
> encrypt-and-MAC, which is not generally considered acceptable. And

I have thought about using one time key before. But that means I need
attach the key with snapshot image. Keyring API doesn't provide interface
for other kernel subsystem to feed an encrypted key blob, so I choice
to use non-ephemeral key that's enrolled by userland through keyctl. I
can change to one time key if keyring subsystem allows to be modified.

The encrypt-and-MAC is not acceptable? I am OK to change to other way
just I hope that I can encrypt/decrypt page one by one for the reason
that I just mentioned.

> you’re not authenticating everything — just the data. This seems very
> weak.
>

Is it too weak? Why?

There have three parts of an snapshot image: 
	image header :: page table pages :: data pages

The real data are in data pages. I thought that encrypt/hmac data pages
can protect sensitive data in pages and also avoid those pages be arbitrary
modified. IMHO arbitrary modifing page table pages is easy to cause
resume kernel crashed.

I keeps iv and signature to image header. They can be public. Did you see
any danger if the header and page table page not be encrypted? Maybe I
missed important things... 
 
> Can you explain the trampoline?  It looks like you are using it to
> tell the resumed kernel that it was tampered with. If so, NAK to that.
> Just abort.
>

The main job of trampoline page is using by boot kernel to forward
key to resume kernel for next hibernation cycle. The authorization result
is just an add on.

In resume process, the key will be loaded in early boot stage. Either in
EFI stub (EFI secure key type, be rejected by EFI subsystem) or initrd. On
the other hand, PCRs may capped after TPM trusted key be loaded. So resume
kernel has no chance to load or unseal key again. The only way to get the
unsealed/decrypted key is from boot kernel.

The trampoline page is an empty page that it's pre-reserved in snapshot image
when hibernation. When resuming, this trampoline page will be written by boot
kernel to fill unsealed key. Then resume kernel will check the trampoline
page to take the key. If the key is empty(zero), which means that boot
kernel didn't forward valid key because some reasons. Either the key is
broken (EFI key be erased) or userspace didn't enroll key to boot kernel.
That's why I check the zero key in code. 
 
> You say “If the encryption key be guessed then the snapshot master key
> can also be grabbed from snapshot image.”  This makes little sense. If
> the encryption key is guessed, the game is over. Just remove this
> patch — it seems like pure snake oil.
>

I agreed.
 
> As far as I can tell, there is only one reason that any of this needs
> to be in the kernel: if it’s all in user code, then we lose “lockdown”
> protection against compromised user code on a secure boot system.  Is
> that, in fact, true?

Putting the logic to kernel has some benefit:

- If the kernel be signed and verified by boot loader in EFI secure boot
  environment. Then the code can also be authenticated with kernel binary.

- Kernel can direct produce an encrypted/signed snapshot image. Either
  kernel or userspace can keep the image. Userspace will not touch an
  un-encrypted image.

Thanks a lot!
Joey Lee 
