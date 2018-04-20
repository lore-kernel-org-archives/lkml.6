Return-Path: <ashok.raj@intel.com>
X-Google-Smtp-Source: AIpwx4+PQCF2vGHk4810KcLDtVNWxX99Y8oZYapGf+btKQSLzUzuyVNemTmBO58Eb5zirEbuqW1o
ARC-Seal: i=1; a=rsa-sha256; t=1524240019; cv=none;
        d=google.com; s=arc-20160816;
        b=kj4TRROQLr87fFmsZFWmJSpmCo5oS5+HY9uesDD/v4WDz2NFixtdghTDsVyY/zGz7w
         7NevgQTb/KprSq+T2tdgOh5so9RbnwsCb5jrbRAQbWGozvLvziRuRFsbYw/dyeLexVi9
         iwPio1VSHgxIb1yBnlPWphmI2YJNEUsveVo9m47BHLQWemoJCOd0xFd13EBvGfdM119O
         AUywxp3EY42cu5wBujvse4XyGr9CkCKyyJjJysRNDsxTki/wyVphVU8pLXeNjLTKs/Jz
         +Vm1aPBuyutEw8I7g6jN5gO9equQJWiRilDRmYB2uDNZyxkymJ80eBSlQENBnquv3r2o
         ishA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Y3rfnBCnnoiAZkzs6iRjbfvcQjz2eRvuqnFTtVINiyw=;
        b=h2SUtLtEWJzeMLcGObXcDkyQn880oF3DCkRBstAXt/UqRBML6OfwoTURXkgFJ3lqN1
         xTEVAAxbTMVD9rEii1SPRUpxbJ+B6dnyKKdt4iq7J5WG5NnnS/0Cax6ZbkRWvvhuVM0d
         7vvtVU9rA91+6oXcXdLu7lkd6udYimHOgcEsA4Kwk/rBCrRdIIxOnaOZ9JwKJTcqTkNi
         Mz9C2rJlC1uwwfAmWVOVBulnl7Iqd1Uaeh/VsyRSutCiPXAEd/EO5lpSJxSa9gh1OAwD
         T5OSTe5z4Ug0J9cE/nqKdbekKdX4ixxoQGBuZbTOQW8XlROwxJEjN1CgsrweZEggDrNS
         v+7g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ashok.raj@intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=ashok.raj@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ashok.raj@intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=ashok.raj@intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,302,1520924400";
   d="scan'208";a="193082415"
Date: Fri, 20 Apr 2018 09:00:18 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Borislav Petkov <bp@suse.de>
Cc: Vitezslav Samel <vitezslav@samel.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, x86-ml <x86@kernel.org>
Subject: Re: [PATCH 2/2] x86/microcode: Do not exit early from __reload_late()
Message-ID: <20180420160017.GB9792@araj-mobl1.jf.intel.com>
References: <20180419104829.GE3896@pd.tnic>
 <20180419120239.GA2377@pc11.op.pod.cz>
 <20180419121840.GF3896@pd.tnic>
 <20180419134627.GA2387@pc11.op.pod.cz>
 <20180419163734.GB3905@pd.tnic>
 <20180420062021.GA2253@pc11.op.pod.cz>
 <20180420095220.GA13977@pd.tnic>
 <20180420100131.GA14217@pc11.op.pod.cz>
 <20180420103242.GB13977@pd.tnic>
 <20180420103708.GE13977@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420103708.GE13977@pd.tnic>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598261173668216348?=
X-GMAIL-MSGID: =?utf-8?q?1598281502508960208?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 12:37:08PM +0200, Borislav Petkov wrote:
> Vitezslav reported a case where the
> 
>   "Timeout during microcode update!"
> 
> panic would hit. After a deeper look, it turned out that his .config had
> CONFIG_HOTPLUG_CPU disabled which practically made save_mc_for_early() a
> no-op.
> 
> When that happened, the discovered microcode patch wasn't saved into our
> cache and the late loading path wouldn't find any.
> 
> This, then, lead to early exit from __reload_late() and thus CPUs
> waiting until the timeout is reached, leading to the panic.
> 
> In hindsight, I should've made that function not return before the
> post-synchronization. Oh well, I know better now...
> 
> Reported-by: Vitezslav Samel <vitezslav@samel.cz>
> Signed-off-by: Borislav Petkov <bp@suse.de>

Tested-by: Ashok Raj <ashok.raj@intel.com>

> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: <stable@vger.kernel.org>
> Fixes: bb8c13d61a62 ("x86/microcode: Fix CPU synchronization routine")
> Link: http://lkml.kernel.org/r/20180418081140.GA2439@pc11.op.pod.cz
> ---
