Return-Path: <sergei.shtylyov@cogentembedded.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521043074; cv=none;
        d=google.com; s=arc-20160816;
        b=b/oAOJF5Vb4pLagKYE+gBVAqyGHyE2H5hmUWH8BterSVvwKPfrQE9Bl+VflA+H6UBX
         FBiX2rPlLkKwwiShnYshmmIEoK+qQ+c2wG8pM59LXsDrixG5++UbL3LuS1C6aGgBu90K
         pwtK/3m/ge+Tjq8Hh6Zy6sCPIckYlBTC+dj7f6ju2OoJIDqdcjwBLkMLzWkAwvLpwILI
         NQcxO6OhDRZfE1qraMfUYnUei85kd66mY38ihvvk2r37Dh1k1OPFhJ3EVZXsG0RFG8Kf
         +w0IX8d3oAhf3XOiN64M+S1jCmvii20KaDkXd5U7qsZlAzHyeomXdtcWX4WvDtSmiBvL
         wGtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=H0VXRVnjO860/47Pv/CuFRLhhTIeiYHJD7tuBFZ2IWM=;
        b=Ot7XoWoCu9Wd4nVjCT8odGTftISkCR3X0dCKovYGJU35vFXestk8hiyKMMnnPc2B5Q
         U2q1/fYg9uq4irCCka00Zyivl9xTUWpV+b+97cevDnKIHPrmKGP5rfJTBT0B7Wu9sViQ
         VKCvU+mSqUnzjPBvMntaUvTrTVPo4DNvwJDzTkwqewANl7GIeV+4nzjE5HIi5K5Muv1m
         TqiBzykOrpHrAM1jdOzUlVj4TxtOUoeZLNIKdxPkyt29zsb9TgddoYQ2491wwgy7LoS6
         Fo/40XsTM4Z4qXRL+jgZvlgrTC+hdcZ+kpb67EMDRoTTYqaUf6hcSukbkP+X9mmz00lB
         hUUA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@cogentembedded-com.20150623.gappssmtp.com header.s=20150623 header.b=BCqLlAwt;
       spf=pass (google.com: domain of sergei.shtylyov@cogentembedded.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sergei.shtylyov@cogentembedded.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@cogentembedded-com.20150623.gappssmtp.com header.s=20150623 header.b=BCqLlAwt;
       spf=pass (google.com: domain of sergei.shtylyov@cogentembedded.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sergei.shtylyov@cogentembedded.com
X-Google-Smtp-Source: AG47ELvKNzD3HrNzNHQ/rsOzwP3/TeGCozmpI04wWef6da0l8O4tiS/TcS/YaGIzvr/wKYCDWE/cOA==
Subject: Re: [PATCH/RFC 1/2] PM / wakeup: Add callback for wake-up change
 notification
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>,
 Len Brown <len.brown@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Marek Vasut <marek.vasut+renesas@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1521026785-26456-1-git-send-email-geert+renesas@glider.be>
 <1521026785-26456-2-git-send-email-geert+renesas@glider.be>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <b2fbba62-72c9-f21a-5aa1-f96291fddb3e@cogentembedded.com>
Date: Wed, 14 Mar 2018 18:57:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1521026785-26456-2-git-send-email-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594912192574352449?=
X-GMAIL-MSGID: =?utf-8?q?1594929262683395180?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/14/2018 02:26 PM, Geert Uytterhoeven wrote:

> Add a callback to inform a device that his wake-up setting has been

   s/his/its/.

> changed.  This allows a device to synchronize device configuration with
> an external user action.
> 
> E.g. on systems using a Rohm BD9571MWV PMIC and a toggle accessory power
> switch, the system suspend procedure is:
>   1. Configure PMIC for DDR backup mode, which changes the role of the
>      accessory power switch from a power to a wake-up switch,
>   2. Switch accessory power switch off, to prepare for system suspend,
>   3. Suspend system.
> 
> Hence step 1 cannot be done in the PMIC's suspend callback, but it can
> be done in the new callback, in response to the user writing "enabled"
> to the PMIC's wakeup virtual file in sysfs.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[...]

MBR, Sergei
