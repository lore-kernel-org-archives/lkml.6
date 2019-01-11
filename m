Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848DBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E5120874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390215AbfAKPAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:00:39 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:48440 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731281AbfAKPAh (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Fri, 11 Jan 2019 10:00:37 -0500
Received: from linux-l9pv.suse (124-11-22-254.static.tfn.net.tw [124.11.22.254])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Fri, 11 Jan 2019 16:00:24 +0100
Date:   Fri, 11 Jan 2019 22:59:58 +0800
From:   joeyli <jlee@suse.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     David Howells <dhowells@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 0/5 v2][RFC] Encryption and authentication for hibernate
 snapshot image
Message-ID: <20190111145958.GA3599@linux-l9pv.suse>
References: <20190103143227.9138-1-jlee@suse.com>
 <20190106181026.GA15256@amd>
 <20190107173743.GC4210@linux-l9pv.suse>
 <CALCETrWHjn_WN1WRc2pbFPB+H-ZL_1y=8dhhHoVqA53Q7Pj5vA@mail.gmail.com>
 <20190109163958.GG9503@linux-l9pv.suse>
 <CALCETrUprUNLci+tQ+P7PV3PvS4ruxz5jrGH3R_FDV4SFp3r9g@mail.gmail.com>
 <20190110151256.GN3599@linux-l9pv.suse>
 <CALCETrU5qWzMSLxa28XHXBsg-gZwkxfzrqztTbBO+qcCYQbTMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrU5qWzMSLxa28XHXBsg-gZwkxfzrqztTbBO+qcCYQbTMA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 05:09:46PM -0800, Andy Lutomirski wrote:
> On Thu, Jan 10, 2019 at 7:13 AM joeyli <jlee@suse.com> wrote:
> >
> > On Wed, Jan 09, 2019 at 10:47:42AM -0800, Andy Lutomirski wrote:
> > > On Wed, Jan 9, 2019 at 8:40 AM joeyli <jlee@suse.com> wrote:
> > > >
> > > > Hi Andy,
> > > >
> > > > Thanks for your review!
> > > >
> > > > On Tue, Jan 08, 2019 at 01:41:48PM -0800, Andy Lutomirski wrote:
> > > > > > On Jan 7, 2019, at 9:37 AM, joeyli <jlee@suse.com> wrote:
> > > > > >
> > > > > > Hi Pavel,
> > > > > >
> > > > > > Thanks for your review!
> > > > > >
> > > > > >> On Sun, Jan 06, 2019 at 07:10:27PM +0100, Pavel Machek wrote:
> > > > > >> Hi!
> > > > > >>
> > > > > >>> This patchset is the implementation of encryption and authentication
> > > > > >>> for hibernate snapshot image. The image will be encrypted by AES and
> > > > > >>> authenticated by HMAC.
> > > > > >>
> > > > > >> Ok, so you encrypt.
> > > > > >
> > > > > > Yes, encryption and authentication.
> > > > > >
> > > > > >>> The hibernate function can be used to snapshot memory pages to an image,
> > > > > >>> then kernel restores the image to memory space in a appropriate time.
> > > > > >>> There have secrets in snapshot image and cracker may modifies it for
> > > > > >>> hacking system. Encryption and authentication of snapshot image can protect
> > > > > >>> the system.
> > > > > >>>
> > > > > >>> Hibernate function requests the master key through key retention service.
> > > > > >>> The snapshot master key can be a trusted key or a user defined key. The
> > > > > >>> name of snapshot master key is fixed to "swsusp-kmk". User should loads
> > > > > >>> swsusp-kmk to kernel by keyctl tool before the hibernation resume.
> > > > > >>> e.g. The swsusp-kmk must be loaded before systemd-hibernate-resume
> > > > > >>
> > > > > >> But if userspace has a key, encryption is useless against root.
> > > > > >
> > > > > > Yes, but this concern is not only for hibernation encryption. This patch
> > > > > > set does not provide solution against this concern.
> > > > > >
> > > > > > The purpose of this patch set is to encrypt and authenticate hibernate
> > > > > > snapshot image in kernel space. It also requests key through keyring
> > > > > > mechanism. Which means that we can easy to adapt to new key type from
> > > > > > keyring in the future.
> > > > > >
> > > > > > Currently TPM trusted key or user defined key types are not against
> > > > > > root. Even using the TPM trusted key, it still can be unsealed by root
> > > > > > before the PCRs be capped (unless we capped PCRs in kernel).
> > > > > >
> > > > > > My solution for keeping the secret by kernel is the EFI secure key type:
> > > > > >    https://lkml.org/lkml/2018/8/5/31
> > > > > >
> > > > > > But the EFI boot variable doesn't design for keeping secret, so Windows
> > > > > > and OEM/ODM do not use boot variable to keep secret. So this idea can
> > > > > > not be accepted. We must think other key type against root.
> > > > > >
> > > > > >>> The TPM trusted key type is preferred to be the master key. But user
> > > > > >>> defined key can also be used for testing or when the platform doesn't
> > > > > >>> have TPM. User must be aware that the security of user key relies on
> > > > > >>> user space. If the root account be compromised, then the user key will
> > > > > >>> easy to be grabbed.
> > > > > >>
> > > > > >> In the TPM case, does userland have access to the key?
> > > > > >
> > > > > > In the TPM case, userland can only touch the sealed key blob. So userland
> > > > > > doesn't know the real secret. But it has risk that root unseals the key
> > > > > > before PCRs be capped.
> > > > > >
> > > > > >> Please explain your security goals.
> > > > > >
> > > > > > My security goals:
> > > > > >
> > > > > > - Encrypt and authicate hibernate snapshot image in kernel space. Userspace
> > > > > >  can only touch an encrypted and signed snapshot image.
> > > > >
> > > > > Signed?
> > > > >
> > > > > I’m not entirely convinced that the keyring mechanism is what you
> > > > > want. ISTM that there are two goals here:
> > > > >
> > > > > a) Encryption: it should be as hard as can reasonably be arranged to
> > > > > extract secrets from a hibernation image.
> > > > >
> > > > > b) Authentication part 1: it should not be possible for someone in
> > > > > possession of a turned-off machine to tamper with the hibernation
> > > > > image such that the image, when booted, will leak its secrets. This
> > > > > should protect against attackers who don’t know the encryption key.
> > > > >
> > > > > c) Authentication part 2: it should be to verify, to the extent
> > > > > practical, that the image came from the same machine and was really
> > > > > created using hibernation.  Or maybe by the same user.
> > > > >
> > > > > For (a) and (b), using an AE mode where the key is protected in some
> > > > > reasonable way.  Joey, why are you using HMAC?  Please tell me you’re
> > > > > at least doing encrypt-then-MAC.  But why not use a real AE mode like
> > > > > AES-GCM?
> > > >
> > > > The reason for using HMAC is the history for development. My first patch
> > > > set is only for hibernate authentication. Then I added encryption code on
> > > > top of my authentication patches in last version.
> > > >
> > > > I am doing encrypt-then-MAC. My code ecrypts each page by AES then HMAC
> > > > whole snapshot image. I feed encrypted data pages one by one to
> > > > crypto_shash_update() API for calculating the hash for whole image.
> > >
> > > ...
> > >
> > > I think you should write down a clear description of the data format.
> >
> > Hibernation allocates free pages for building snapshot image. Those free
> > pages are scattered in memory. So kernel marks those page numbers on a
> > bitmap to locate them. Because this image buffer is discontinuous, so I
> > use update mode hashing whole image.
> >
> > > A general problem with crypto is that the fact that it appears to work
> > > doesn't mean it's secure at all, and it's very hard to follow the
> > > code.  Especially in Linux using the crypto API -- code using the
> > > crypto API tends to be mostly boilerplate.
> > >
> >
> > hm... Do you mean that the implementation of HMAC in crypto cannot be
> > trusted? I hope at least that I can trust the update mode for normal
> > hash like SHA256 or SHA512?
> 
> No, I fully expect the crypto code to do what it says.  What I mean is
> that you can easily create utterly broken things that involve crypto,
> but they still work fine when you use then non-maliciously.
>

OK, I see! I will review my code with crypto to make sure that I didn't
create broken things.
 
> > > >
> > > > Sorry for I didn't capture the meaning of "acceptable usage". The trusted
> > > > key already be unsealed by TPM when the key be enrolled by keyctl tool.
> > > > So my code just extract the unsealed key data (the random number) for
> > > > encryption.
> > >
> > > If someone creates a trusted key that is used for asymmetric crypto or
> > > perhaps a trusted key that is intended to be used for, say, an HMAC
> > > key, you should not also use it to derive hibernation keys.  This is
> > > what I mean by "acceptable usage".
> > >
> >
> > When keyring is producing encrypted key, the trusted key be used to
> > derive the encrypt key and authenticate key to encrypt and hmac sign
> > a encrypted key. So trusted key can be used in symmetric crypto.
> 
> Can it?
> 
> David, you actually understand the overall kernel keyring design.  Do
> keys in the keyring have usage constraints?
> 
> But I think you need to take a big step back here.  We already have
> kernel/power/user.c.  It seems to me that you can do a better job of
> what you're trying to do with less code by using it.  Why do you need
> new kernel code *at all* to accomplish your goals?

I still very think for you, Stephan, Pavel and all kernel experts'
review to my code. I will follow your suggestions to rewrite my
solution.

I thought that the userland hibernation is not enough against a
compromised root. My original target of hibernation encryption and
authentication is for kernel lockdown mode. I hope that kernel can
produce encrypted/signed snapshot image. So I developed EFI secure
key and hibernation encryption.

Becasue my original solution relates two areas, EFI and hibernation.
So I separated them and sent them to kernel upsteam for review. The
EFI seucre key is not accepted so I moved to use TPM trusted key.
I thought that the final problem is still how to deal with TPM against
a compromised root.

Thanks a lot!
Joey Lee
