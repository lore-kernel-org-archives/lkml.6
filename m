Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752661AbeDCQ4e (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 12:56:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:50303 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752397AbeDCQ4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 12:56:31 -0400
Date: Tue, 3 Apr 2018 16:56:27 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>, Peter Jones <pjones@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Gary Lin <GLin@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC PATCH v1] fw_lockdown: new micro LSM module to prevent
 loading unsigned firmware
Message-ID: <20180403165627.GW30543@wotan.suse.de>
References: <1510347775.3549.2.camel@linux.vnet.ibm.com>
 <21dd4b88-f6e7-f6bb-e34d-ba8ef3755622@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21dd4b88-f6e7-f6bb-e34d-ba8ef3755622@kernel.org>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 05:42:22PM -0700, Andy Lutomirski wrote:
> On 11/10/2017 01:02 PM, Mimi Zohar wrote:
> > If the kernel is locked down and IMA-appraisal is not enabled, prevent
> > loading of unsigned firmware.
> 
> > diff --git a/security/fw_lockdown/Kconfig b/security/fw_lockdown/Kconfig
> > new file mode 100644
> > index 000000000000..d6aef6ce8fee
> > --- /dev/null
> > +++ b/security/fw_lockdown/Kconfig
> > @@ -0,0 +1,6 @@
> > +config SECURITY_FW_LOCKDOWN
> > +	bool "Prevent loading unsigned firmware"
> > +	depends on LOCK_DOWN_KERNEL
> > +	default y
> > +	help
> > +	  Prevent loading unsigned firmware in lockdown mode,
> 
> Please be honest about what this does.  This option makes your system
> useless if you don't use IMA-Appraisal and it offers a particular security
> benefit if you do you IMA-Appraisal.  How about making it depend on
> IMA-Appraisal?  Change the name to SECURITY_ONLY_LOAD_IMA_APPRAISED_FIRMWARE
> and adjust the text accordingly, please.

Mimi is on vacation right now so I'll address this.

All the above makes sense, but just keep in mind the patch was posted just as
an illustration of how IMA *can* live up to the original intent proposed by
David Howells on kernel lockdown. David's old kernel lockdown documentation
stipulated that a requirement was to also prevent loading unsigned firmware.

Does the kernel lockdown documentation still have a section indicating signed
firmware is a requirement? Or was that removed in the end?

Mimi's RFC was at a time when we still had on our roadmap the prospect of
adding generic signed firmware support into Linux. Mimi's point and RFC patch
was an illustration then on how IMA users can already meet these assumed
requirements on 'kernel lockdown', and that if we used a micro LSM hook this
could be easily managed, given the firmware signing support we intended on
adding would not be needed for IMA systems. Her point was that with IMA you can
already meet the definition and IMA systems would not have to wait for "generic
firmware signing" to be merged.

The biggest thing which has changed since then is that we decided to *not*
support or streamline generic firmware signing (non-IMA) for now for a few
reasons [0] [1] which are important to re-iterate as these are easy to forget,
and AFAICT not documented anywhere.

One was that my own requirement for it was already done -- cfg80211 already
open codes firmware signing checking on its own through the new
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB thereby also not requiring CRDA anymore,
the userspace component which used to read the signed regulatory database and
then send regulatory content to the wireless subsystem. So CRDA is no longer
needed if you enable CONFIG_CFG80211_REQUIRE_SIGNED_REGDB.

Second, is is that the whole UEFI movement pushed hardware vendors to start
embracing requiring signed firmware on peripherals themselves. So a lot of
hardware these days *does* do firmware signing already and a generic kernel
firmware signing facility would then just make us do double work then. There
are exceptions and there are a few reasons for this. For instance USB devices
are not allowed to pee on random memory (thanks for the analogy Alan!), so
not all USB devices have support for checking their own firmware signature.
This is one reason also why why some operating systems do not allow users
to use random USB devices. If companies *really* need to vet for these they
have a few options, one is to use IMA, the other is to have the driver open
code the firmware signing component just as we did with cfg80211 through the
new CONFIG_CFG80211_REQUIRE_SIGNED_REGDB. If we end up later with enough
open coded firmware checking users we can later revisit adding a generic
firmware signing facility.

Third is that there is no strong evidence of any security issue with having
firmware in /lib/firmware not be signed. I can attest to this, in my research
of all the history of this, I cannot find a single incident which calls bloody
murder for unsigned firmware.  There are concerns and known backdoors on
firmware for storage drives for instance, but these are not /lib/firmware
files, for instance. If you also consider the second reason above, it may also
help explain why perhaps there is also any serious threat on this front.
Granted, there are known cases know of a third party using some signing key to
sign malicious firmware and using that to exploit an OS, but if they did that
and we trusted each vendor signing key as well we'd be just as vulnerable.

Fourth, if you want signed /lib/firmware, you might want signed binaries, and
if you want signed binaries, we already have IMA.

So.. until there is no real strong reason to support and maintain a generic
firmware signing mechanism, no need to add it. We can wait for the open coded
boom, and if that really does happen we'll revisit later.

So the kernel lockdown definition may want to revise all the above, review its
documentation and if the "firmware signing" aspect is still there, update it
somehow to reflect or ignore the above.

If we want to keep "signed firmware" as a requirement for "kernel lockdown"
then we have no option to also amend the definition I think to consider signed
executables, and imply or recommend the use of IMA. If the assumption is that
peripherals or drivers all have hardware firmware signing support and are OK
with random USB gadgets, then perhaps we are OK in removing (if its not already
removed) the "signed firmware" requirement from the "kernel lockdown"
definition, and the concept of signed firmware or IMA can live on as additional
effort for now.

However, *iff* we *really* want to push again for generic "signed firmware", we
want a good justification for it considering all the above. To be fair I'll
note that I don't recall a super strong justification for signed modules back
in the day, other than Rusty saying 'its happening', 'its being merged', and that
some companies wanted it.  I think we do have the case of companies wanting signed
firmware in this case as well... however the issue is the foundations may be on
a warm fuzzy feeling only, and a big difference is that with modules you don't
have peripherals checking for the signed bits, with firmware we do have this
practice growing these days.

If we *do* end up moving forward with generic "signed firmware" later though,
the architecture for it would be through a micro LSM as Mimi suggested in this
patch, and it would whitelists IMA. The patch would also need to be updated to
whitelist the new CONFIG_CFG80211_REQUIRE_SIGNED_REGDB and any other open coded
signed firmware bits which may get merged later.

  Luis

> > +/**
> > + * fw_lockdown_read_file - prevent loading of unsigned firmware
> > + * @file: pointer to firmware
> > + * @read_id: caller identifier
> > + *
> > + * Prevent loading of unsigned firmware in lockdown mode.
> 
> That comment gives a highly misleading impression of what this function
> does.
> 
> > + */
> > +static int fw_lockdown_read_file(struct file *file, enum kernel_read_file_id id)
> 

-- 
Luis Rodriguez, SUSE LINUX GmbH
Maxfeldstrasse 5; D-90409 Nuernberg
