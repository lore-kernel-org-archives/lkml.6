Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754183AbeBPIZC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 03:25:02 -0500
Received: from parrot.pmhahn.de ([88.198.50.102]:51478 "EHLO parrot.pmhahn.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753977AbeBPIZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 03:25:00 -0500
Subject: Re: [PATCH] Make kernel taint on invalid module signatures
 configurable
To: Matthew Garrett <mjg59@google.com>, Jessica Yu <jeyu@kernel.org>
Cc: Ben Hutchings <ben@decadent.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20170807195027.13192-1-mjg59@google.com>
 <CACdnJus-X533K0Bgqjc-MoZ2NbLz0ac9x+rryHUtnjrnmJ+Kmg@mail.gmail.com>
 <20180215152514.rxmh7webdg2i2fct@redbean>
 <CACdnJutL7rJE=1bsh45RmvunU-GZJCYaejyznENrAgFB6nbCLA@mail.gmail.com>
From: Philipp Hahn <pmhahn@pmhahn.de>
Message-ID: <ff79053c-4a4c-714e-4098-bf973eaefd63@pmhahn.de>
Date: Fri, 16 Feb 2018 09:24:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACdnJutL7rJE=1bsh45RmvunU-GZJCYaejyznENrAgFB6nbCLA@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------5ECF84BE8FFF0A61C433A721"
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5ECF84BE8FFF0A61C433A721
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hello,

Am 15.02.2018 um 20:36 schrieb Matthew Garrett:
> On Thu, Feb 15, 2018 at 7:25 AM Jessica Yu <jeyu@kernel.org> wrote:
>>  From what I understand from Ben's post from last year
>> (http://lkml.kernel.org/r/1504044122.4448.24.camel@decadent.org.uk),
>> it sounds like the main issue is that Debian doesn't support their own
>> centralised module signing yet, causing all of their modules to be
>> automatically tainted if they enable CONFIG_MODULE_SIG, and that a new
>> option like this would likely be used as a temporary "fix". Am I
>> understanding correctly?
> 
> Not entirely. There's two cases where the current situation causes problems:
> 
> 1) Distributions that build out of tree kernel modules and don't have
> infrastructure to sign them will end up with kernel taint. That's something
> that can be resolved by implementing that infrastructure.
> 2) End-users who build out of tree kernel modules will end up with kernel
> taint and will file bugs. This cannot be fixed but will increase
> distribution load anyway.

Just yesterday I sent the attached email to the crypto/-maintainers as I
have read some Fedora documentation about adding the UEFI SecureBoot
keys to the kernel secondary trusted keyring:
<https://docs-old.fedoraproject.org/en-US/Fedora/23/html/System_Administrators_Guide/sect-kernel-module-authentication.html>

Sadly didn't work for me :-(
If my understanding is correct and iff that would work, Debian (and
others) could load their public key into Shim and then use the
associated private key for singing their modules.

Debian currently plans to have a Sprint for their SecureBoot process in
April, which I will attend. Hopefully we will find a solution their:
<https://wiki.debian.org/Sprints/2018/SecureBootSprint>

Philipp (also a Debian developer)

--------------5ECF84BE8FFF0A61C433A721
Content-Type: message/rfc822;
 name="Nachricht als Anhang"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="Nachricht als Anhang"

To: David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>
From: Philipp Hahn <hahn@univention.de>
Subject: [linux] .system_keyring ?
Organization: Univention GmbH
Cc: keyrings@vger.kernel.org
Message-ID: <49ef1eb6-802b-ae86-a5e4-eb29a8ef4c4c@univention.de>
Date: Thu, 15 Feb 2018 12:51:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hello,

reading "Documentation/admin-guide/module-signing.rst":
> The kernel contains a ring of public keys that can be viewed by root.  They're
> in a keyring called ".system_keyring" that can be seen by::
> 
>         [root@deneb ~]# cat /proc/keys
>         ...
>         223c7853 I------     1 perm 1f030000     0     0 keyring   .system_keyring: 1

I don't have that ".system_keyring":
> cat /proc/keys
> 00a8459a I------     1 perm 1f0f0000     0     0 keyring   .secondary_trusted_keys: 1
> 02b66804 I--Q---     8 perm 3f030000     0     0 keyring   _ses: 1
> 0639503a I--Q---     3 perm 1f3f0000     0 65534 keyring   _uid.0: empty
> 1afb3552 I------     2 perm 1f0b0000     0     0 keyring   .builtin_trusted_keys: 1
> 3167cca3 I--Q---     1 perm 1f3f0000     0 65534 keyring   _uid_ses.0: 1
> 37b744d9 I------     1 perm 1f030000     0     0 asymmetri Build time autogenerated kernel key: 8943e26cd249e2fcdafea805149fcf9ed5912e10: X509.rsa d5912e10 []

Grepping the Linux kernel source tree git also find no '.system_keyring'
in any source file - only the name of the header file and in Documentation/.
Am I missing something? If that documentation out-dated?

My .config is this:
> $ sed -ne 's/^config /CONFIG_/p' certs/Kconfig | ssh uefi 'grep -F -f - /boot/config-`uname -r`'
> CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
> CONFIG_SYSTEM_TRUSTED_KEYRING=y
> CONFIG_SYSTEM_TRUSTED_KEYS=""
> # CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
> CONFIG_SECONDARY_TRUSTED_KEYRING=y


I was looking at
<https://docs-old.fedoraproject.org/en-US/Fedora/23/html/System_Administrators_Guide/sect-kernel-module-authentication.html>
and I'm trying to get my UEFI keys added to the Linux keyring. I want to
sign my modules with that "external" key instead of embedding the key
into the Linux kernel itself.

Thanks in advance.

Philipp

PS: I'm not subscribed to 'keyring, but LKML.
-- 
Philipp Hahn
Open Source Software Engineer

Univention GmbH
be open.
Mary-Somerville-Str. 1
D-28359 Bremen
Tel.: +49 421 22232-0
Fax : +49 421 22232-99
hahn@univention.de

http://www.univention.de/
Geschäftsführer: Peter H. Ganten
HRB 20755 Amtsgericht Bremen
Steuer-Nr.: 71-597-02876

--------------5ECF84BE8FFF0A61C433A721--
