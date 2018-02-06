Return-Path: <heikki.krogerus@linux.intel.com>
X-Google-Smtp-Source: AH8x224uhjsG0DoRZNKoaUT54fTPJO+OjBE6toBJhRzDUqkRGUh84wSCb00k9KiaOESU9Su6an3G
ARC-Seal: i=1; a=rsa-sha256; t=1517928842; cv=none;
        d=google.com; s=arc-20160816;
        b=V8vXaDxI7Emz5rDRBjOwHQKpSocaUSprUyMRnvxRnf2for3eqv1ehuGxKJAjL+M4y5
         PEbSs/0HDehpnH3DXeJP7eTSMfdhOZzC9NyNKNCPovjEH035ZdJMA1+gLcIP2Ixrfext
         3N7LBCrpNSBUquVFyZREpmKX8ZZAa51LEgJ6UiYjzl5gzW2GdiCVsKkgGCtb/RqvDtZi
         Vsy4ACaZ61fcikqjn8Td+5SfV1wttDlF5VVdSzuLT84Iz0cqPNCrVgzyhEMAvLgMDDkU
         WQDvrk6jOXTZd22bVVu3Z7r73eHfFHl8GnHWK4YK0unMuicIB8TZYaG6tLkY0eJYU7eH
         CFMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=0FXVvs1V56wsQDYfKzgmTUxvQWQ2PCRsEF6Ucbm4pH8=;
        b=wIUXG1T3MKG3O8zBtVHLEi5UPV90eRp3NNzqxKPGGgd79nXymuYJY9HV2I8QYgBkls
         3HevkjsNPCAG5G0Wx3FcneB/npX0rciE5AWHQ8Zm2HwvBGjerlSaeCBXffS3LETbgTKA
         iAhtSXHR1BEoGvRXZ0M1t+uwiaI9jvsej56gqfVx0NDwOYG4stUo4WWmERPmPQ4zKnax
         tmj68sCShVyfo3Elk6p5yeVtoRb2bw+WDrADitJUmYXQNWMHiaAhF/Q+c98CkLsmi3yL
         MCGF6eUuMOOlfw3Lf/S/2I88pxFwZv5YU5Hwak7pzSCgt9jRVIW52JBxlIl9eI51egZu
         JSSw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,469,1511856000";
   d="scan'208";a="28538436"
Date: Tue, 6 Feb 2018 16:53:57 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Yueyao Zhu <yueyao.zhu@gmail.com>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Support Opensource <Support.Opensource@diasemi.com>
Subject: Re: [PATCH v4 4/7] typec: tcpm: Add core support for sink side PPS
Message-ID: <20180206145357.GA25136@kuha.fi.intel.com>
References: <cover.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
 <26195a73c6f2f379b47dd39f23db9c2feec20371.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
 <20180130124653.GD14922@kuha.fi.intel.com>
 <2E89032DDAA8B9408CB92943514A0337014C1C1538@SW-EX-MBX01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337014C1C1538@SW-EX-MBX01.diasemi.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1588496437920518936?=
X-GMAIL-MSGID: =?utf-8?q?1591663754696262904?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 06, 2018 at 02:33:08PM +0000, Adam Thomson wrote:
> On 30 January 2018 12:47, Heikki Krogerus wrote:
> 
> > > +static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
> > > +{
> > > +	unsigned int target_mw;
> > > +	int ret = 0;
> > > +
> > > +	mutex_lock(&port->swap_lock);
> > > +	mutex_lock(&port->lock);
> > > +
> > > +	if (!port->pps_data.active) {
> > > +		ret = -EOPNOTSUPP;
> > > +		goto port_unlock;
> > > +	}
> > > +
> > > +	if (port->state != SNK_READY) {
> > > +		ret = -EAGAIN;
> > > +		goto port_unlock;
> > > +	}
> > > +
> > > +	if (op_curr > port->pps_data.max_curr) {
> > > +		ret = -EINVAL;
> > > +		goto port_unlock;
> > > +	}
> > > +
> > > +	target_mw = (op_curr * port->pps_data.out_volt) / 1000;
> > > +	if (target_mw < port->operating_snk_mw) {
> > > +		ret = -EINVAL;
> > > +		goto port_unlock;
> > > +	}
> > > +
> > > +	reinit_completion(&port->pps_complete);
> > > +	port->pps_data.op_curr = op_curr;
> > > +	port->pps_status = 0;
> > > +	port->pps_pending = true;
> > > +	tcpm_set_state(port, SNK_NEGOTIATE_PPS_CAPABILITIES, 0);
> >
> > Why not just take the swap_lock here..
> 
> I believe this would result in deadlock. All of the existing uses of swap_lock
> acquire it first before the port->lock is then acquired (and vice-versa for
> unlock). We don't want the power role to change during this procedure, so we
> hold the swap_lock for the whole process. Have a look at tcpm_dr_set() and
> tcpm_pr_set() as examples of existing usage.

OK. Then I'm fine with this patch as well. FWIW:

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

-- 
heikki
