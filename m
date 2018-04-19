Return-Path: <vitezslav@samel.cz>
X-Google-Smtp-Source: AIpwx49Se3Ne0T+vG0+w9yo166FtUERPsCGz9QwUnrMVpMiII6OoY/lw17z7sYDyIsoAep/qi6WZ
ARC-Seal: i=1; a=rsa-sha256; t=1524116133; cv=none;
        d=google.com; s=arc-20160816;
        b=skabgT9VPzAh8BzTvW6igboNYsQ/0V6poQ5aw70smtfiYvGSE1zoGu4DmdrPuQwBfC
         sv7V4mUa9hVEIPbIjWc4jjRLSM00OxhnSfDWizOYjuPuOwfhLlsR0kYOroqgtAW5Z0J0
         zMvyO2BseBE2DyF/3D9x0+1YajQOM+WtTYO+NXsSBL8k6O5W8XgRjvRCC57p8ndKzDyx
         hOk5f9v2KPLm6xwRN+jF6fj8izSJmwD+YaMVUS8C4/Qf5zpFx1ElJ9TTf3ug2ZTYdAOb
         y7SUjC2ucjpp5e/fOQfPr8UXvQXEWBUpfWKPDD97hdMkJBGZXT1F98sBKS4w0Fp8jyJQ
         x00Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=rkuu+MTkazBEz7YrYtjsHWIdUVRSnXAhFShl5Drmg5E=;
        b=n2CRO0IsKdyKLqUm8RfIdCbk9cDOIVFH/pyOqjsdtNdi0wsLg3m3hKk32T9VvfSapK
         7e2VnyIruMiPsl2jhBhNyUiUJB3xYOF/K3TurIMU4OcaoDPThPuYL/iMT2SmWiSqworA
         jj/DJJjYDwN2KPfqgYuetYywish127cjBHuqwVDijdWz/u4Qeu+QM3KYN+lIcYvW0VBS
         1P2TNdT4NKHtvfnz/ayN26nlXVtC0G7epRrwKzRG+Qx54/b60DvQ4fV/iK3xYoTyWYRu
         +fMrgi4YpS8de5UJMNbEmbtj1Xq1EApP5n98Ssz83U5UMRHqB5kgenQPI4bHq+UdXA/b
         3IFg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 213.155.227.146 is neither permitted nor denied by best guess record for domain of vitezslav@samel.cz) smtp.mailfrom=vitezslav@samel.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 213.155.227.146 is neither permitted nor denied by best guess record for domain of vitezslav@samel.cz) smtp.mailfrom=vitezslav@samel.cz
Date: Thu, 19 Apr 2018 07:35:31 +0200
From: Vitezslav Samel <vitezslav@samel.cz>
To: "Raj, Ashok" <ashok.raj@intel.com>
Cc: Borislav Petkov <bp@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: 4.15.17 regression: bisected: timeout during microcode update
Message-ID: <20180419053531.GA2224@pc11.op.pod.cz>
Mail-Followup-To: "Raj, Ashok" <ashok.raj@intel.com>,
	Borislav Petkov <bp@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
References: <20180418081140.GA2439@pc11.op.pod.cz>
 <20180418100721.GA5866@pd.tnic>
 <20180418120839.GA5655@pc11.op.pod.cz>
 <20180418122212.GA4290@pd.tnic>
 <20180418135330.GA23580@araj-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418135330.GA23580@araj-mobl1.jf.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598070825045426546?=
X-GMAIL-MSGID: =?utf-8?q?1598151599156276590?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 06:53:30AM -0700, Raj, Ashok wrote:
> On Wed, Apr 18, 2018 at 02:22:12PM +0200, Borislav Petkov wrote:
> > On Wed, Apr 18, 2018 at 02:08:40PM +0200, Vitezslav Samel wrote:
> > > I switched to firmware-in-kernel early loading and that works OK.
> 
> firmware-in-kernel means you compile your microcode image in linux?

  Yes:

	CONFIG_FW_LOADER=y
	CONFIG_EXTRA_FIRMWARE="intel-ucode/06-3c-03"
	CONFIG_EXTRA_FIRMWARE_DIR="/lib/firmware"

> Can you tell me which distro you are using? The ones we used 
> doesn't do late-loading (i.e echo 1 > /sys/devices/system/cpu/microcode/reload)
> 
> I suspect that might be the problem. 

  Yes, this is it. I followed instructions included in current microcode
package downloaded from intel website and added "echo 1 > /sys/dev..."
to my Slackware's /etc/rc.d/rc.local.

> - Can you remove your builtin microcode, 
> - rename the /lib/firmware/intel-ucode so we don't find it during late loading. 
> - let the system boot completely
> - then rename the intel-ucode back for this test.
> - write 1 to reload and see if that update succeeds or fails?

  Just tested, it fails.

	Cheers,

		Vita

> > Ok, and keep using that from now on.
> > 
> > People should all move away from that late loading dance. I'm saying
> > that in case someone else reads this on lkml.
> > 
> > > But still, the reported issue is regression in 4.15.17 and 4.16+.
> > 
> > Oh, I know it is a regression.
> > 
> > @Ashok: anything particular about his microcode revision not being able
> > to stomach late loading?
> 
> nothing about the microcode itself comes to mind. I'm wondering if this 
> similar to the Arch linux that used late-load during booting might be an issue.
