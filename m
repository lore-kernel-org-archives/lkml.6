Return-Path: <sjg@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524691079; cv=none;
        d=google.com; s=arc-20160816;
        b=llf1S406l5hLSGbFKCyokAzAiLKTn38W1ZR36Y5l9G3eVQ7hwAaPne67d+S5UFhZDf
         jSXWZSn9AUmWZApJP5fy924PeDk2xyfzJdgazp5SgJehHZcIe7pIZysMrgYLM24Cf4Bz
         M6DpOhPI9moAni3el3Homjl7IXj/jCw8c06sNTx5HEeq+m+KXbOFil1tkDmCq2T6Ofzs
         S4+TZKTz8jAHNAJZwlHU5D5b3yUwTiuY6dPt1PNAQsezdprA73wEIrGWcpQF+17vrnAR
         txgtuLklQagVNktC1nW8o7DxuLutZuNLLaBBJ5oqguSj3yyIy4mLtmkoubkQ/HOhASsb
         c4ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=bYue5zm7xaix5liUU78Lg6+qvYQ2Gr0Urvjf+XwZALo=;
        b=gZWf1Va4IMwwP3SLmulerjddaYbpJrEnIpHQ/m9nNgfMncdMKmrJTHTOs3dCn9q0Pm
         UFIvHc3fhRCfjQ8IgFDuvbmx2kA1cOgCjvsh0hKCkHIMjvw6J0DUu/LDUoBngxxerMtn
         dgSsU3pbsdJWK4Jt7F/hRVO7sZGUYXaSn7ytQkyMOFQnVgF0u+knydZIHDFXhhSS4PMq
         IubE0T+ljGk1xjnwZSjFpUqd2adF1uTkSLTwJcBK2BBOnGpyeu4xK0qiVtBTsuFOC2rT
         Q/w0qsI01kYROg5qWLYb97/phOiBXWLBpBHnZ8UMzmtJM003Q/KlRSeuEYbKF9G8myeU
         9ARg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=DC7cavce;
       dkim=pass header.i=@chromium.org header.s=google header.b=SJo5K663;
       spf=pass (google.com: domain of sjg@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=sjg@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=DC7cavce;
       dkim=pass header.i=@chromium.org header.s=google header.b=SJo5K663;
       spf=pass (google.com: domain of sjg@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=sjg@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AB8JxZqu6V5hbG+gOjYUdWD0v36owwz+mvXn69ByJw+uNcV3PNqZVbN7Yk2X9RkGorIQlTmBc/5HhIU3wbk57KX4L2g=
MIME-Version: 1.0
Sender: sjg@google.com
In-Reply-To: <20180425025125.GH6014@localhost>
References: <20180424211111.140374-1-sjg@chromium.org> <20180425025125.GH6014@localhost>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 25 Apr 2018 15:17:37 -0600
X-Google-Sender-Auth: jZycIQjnhmlGAlabiVrDoxoi8eQ
Message-ID: <CAPnjgZ1ExEQHL8W2+k=+wS98O3CCX25dKngv_PFNvgAKVBD4Hw@mail.gmail.com>
Subject: Re: [PATCH] firmware: dmi: Add access to the SKU ID string
To: Vinod Koul <vinod.koul@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, C Shapiro <shapiroc@chromium.org>,
	Aaron Durbin <adurbin@chromium.org>, Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>, Philippe Ombredanne <pombredanne@nexb.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alex Hung <alex.hung@canonical.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jean Delvare <jdelvare@suse.com>, sayli karnik <karniksayli1995@gmail.com>,
	Sagar Dharia <sdharia@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598663453447525196?=
X-GMAIL-MSGID: =?utf-8?q?1598754472827258741?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Vinod,

On 24 April 2018 at 20:51, Vinod Koul <vinod.koul@intel.com> wrote:
> On Tue, Apr 24, 2018 at 03:11:11PM -0600, Simon Glass wrote:
>> This is used in some systems from user space for determining the identity
>> of the device.
>>
>> Expose this as a file so that that user-space tools don't need to read
>> from /sys/firmware/dmi/tables/DMI
>
> sysfs is an ABI and needs to be documented, I don't see that in this patch,
> pls add.

Thanks for taking a look. The only mention of the dmi/id I can find is
in Kconfig:

config DMIID
    bool "Export DMI identification via sysfs to userspace"
    depends on DMI
    default y
help
  Say Y here if you want to query SMBIOS/DMI system identification
  information from userspace through /sys/class/dmi/id/ or if you want
  DMI-based module auto-loading.


Are you suggesting that I create a list of the things in the /id node,
or something else?

Regards,
Simon
