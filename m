Return-Path: <groeck7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521724812; cv=none;
        d=google.com; s=arc-20160816;
        b=M0Duf0SEvUuYhD51Z70U6TGB/GLvGQVt+wcnzzpnU6DY9b9A8JvuZ5dbNYGIdCAVkL
         sTu47z0MkB8WOdqo0McMFpo9Bec/+6E7v0djD13WBn9Lah83qKgwSu2JynMQ6AfXEnfe
         AaO0AJV/CqbEgycJ4WbMUIWn1M5ET0/19mwUooGA+YjVN9EbqzyVFjxqGOa17oKoLU/U
         nP0mdCWXmPBtkobcs1xxhGKmKZDpC8fnZkhOzZmai4hgG7+08eGyrnSjLMvcyUkDVjd9
         aO3gCTB+UZLH+D+X4TC6RT3QlYaLT32wrr3l2y8A4FNSTaGlAFoqQFelYupQSObml1BI
         g8+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:sender
         :dkim-signature:arc-authentication-results;
        bh=5u+q3Q5JYWDhOUU400eTO7HJArAkKinhNK1KVmHX2pI=;
        b=E5oHzCOt2V2DS/bXbR5Q9mQEsPWD/ZupC940XASdnUhKf3bXi+cJno6/636QjPDPa1
         4b5V1P7YKaVJdaslO/WwjEwkBGsDo7UMBoRRFFFxwrlDCACLqL2OLbvrc6ezVX1VyiQ6
         ZPevyEmoDrffQF3UgnR5+JTLR0q4p+J860EoCUkPUb0iRNe9lHTfr6yxtizmpS6563cm
         YmPWd4KpPhZ/k1sZxjalGHjQqHiAYwvbn0xkWLU0fSNa1Ni4AGqCRtjPYCy8s1nE09pi
         J5r+OgWvCNhcWxdf5XrHngNkYy7yzgRuVrpHdhVwcXs1OTSuyHt7lmxaVbC1onAw8Q1N
         /lXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=UzUwl9J0;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=UzUwl9J0;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
X-Google-Smtp-Source: AG47ELtCbRccigs8D1SDTpwCZ9TTXmAIoP9lYeRs6HmdIP893giWlc7sGc0BX8Xcn7mzF6cqymLOng==
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v5 4/5] typec: tcpm: Represent source supply through
 power_supply
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Jun Li <jun.li@nxp.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Support Opensource <Support.Opensource@diasemi.com>
References: <cover.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
 <510c0897961f234daca295b273bf4e5047498c55.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
 <b2d508dc-c344-6447-1c50-69f268fdbb83@roeck-us.net>
 <2E89032DDAA8B9408CB92943514A0337014C1E28A3@SW-EX-MBX01.diasemi.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <03fddd26-f554-b4a5-3fd3-04a7921a9f29@roeck-us.net>
Date: Thu, 22 Mar 2018 06:20:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337014C1E28A3@SW-EX-MBX01.diasemi.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595467553265971470?=
X-GMAIL-MSGID: =?utf-8?q?1595644116546253820?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/22/2018 03:40 AM, Adam Thomson wrote:
> On 22 March 2018 04:09, Guenter Roeck wrote:
> 
>>> +static int tcpm_psy_set_prop(struct power_supply *psy,
>>> +			     enum power_supply_property psp,
>>> +			     const union power_supply_propval *val)
>>> +{
>>> +	struct tcpm_port *port = power_supply_get_drvdata(psy);
>>> +	int ret = 0;
>>> +
>>> +	switch (psp) {
>>> +	case POWER_SUPPLY_PROP_ONLINE:
>>> +		ret = tcpm_psy_set_online(port, val);
>>> +		break;
>>> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>>> +		if ((val->intval < (port->pps_data.min_volt * 1000)) ||
>>> +		    (val->intval > (port->pps_data.max_volt * 1000)))
>>> +			ret = -EINVAL;
>>> +		else
>>> +			ret = tcpm_pps_set_out_volt(port, (val->intval / 1000));
>>> +		break;
>>> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
>>> +		if (val->intval > (port->pps_data.max_curr * 1000))
>>> +			ret = -EINVAL;
>>> +		else
>>> +			ret = tcpm_pps_set_op_curr(port, (val->intval / 1000));
>>
>> I am really not a friend of excessive ( ).
> 
> Yes, I got that. :) I am of the opinion that they should be used to enforce
> precedence. This to me is good coding practice and makes it unambiguous for the
> reader. That's why I use them as above. Do you think the above uses make it
> harder to understand or more difficult to maintain?
> 
It confuses me and makes me think I am missing something, and causes me to miss
the _real_ problems. If the compiler is not able to enforce precedence, even more so
in situations like the above, I think it is about time to dump it.

Either case, your call to make. I wont give patches with excessive ( ) a Reviewed-by:,
but then others can review the code.

Thanks,
Guenter
