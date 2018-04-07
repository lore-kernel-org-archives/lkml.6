Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AIpwx4/tyw1siMNFUotit9yiEbmOWKkYndAro8yhkPu3Ep2jJs+QgnsgVs3R+yuL8lEnJbd0Oxjj
ARC-Seal: i=1; a=rsa-sha256; t=1523119047; cv=none;
        d=google.com; s=arc-20160816;
        b=wKFmrhjZix6U5fRDHJnkAjbqWWfwFQQWwU8OjDfM8tGqfQ+0i4WArGNW5bRApP698n
         86AVN6hcpPQX06s5MskIYRXtByYgFT1efRs+conEIhd2BumD+W0gOH/SA/WgsARtYvu9
         BzYIXxxJI9WMbqSo/ixMylYwjq1K6syjhSrmf62SxZNRg+ddtJFmnn8Fa2k0YGq6zIQD
         vDtSBeAutbyqpENB6etKlYINeN76RDlMmRAnRUdSxa9j2+xwMm32M8HbhecmJY7SA30R
         YmWnp/eqUeZIXTezChwzOXPoYIXz34O1rpYxR7fpm9P3LYhxLZliDFLSDcVGKvlbfeiy
         OOXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=ctSeIar2ygbFRVwutq5ieCCAm5rJJYcR0L+ogxSNcDY=;
        b=Hmq127CORY//v8bexo3px4st0Q7rOgnBLaXPoVFgzkCT41cK9pdc+PLAb0e2nIWjX0
         MUSoO6c4JRd2UEC+EqdRGtAEWPewlGPMRZgvBxuxrDU5iR+NqpQ9nE9KbuEqW84mJRAK
         43FuQbYAW0Pbc7R/1rEYY+/CqG8ZFSr2nPkBld0vNGOzx14rmGxafAA835ZvGbkqms1f
         nHWuaWlt8cmv3htbip+RgmMFptqfsC3lCW5DBruE4QtAv5O4mll2+38ZTyh8dp4+KjV0
         siTmFmAVK+b4r6/taHjqWPtJT8EhV5+TzbeAf3kJIuY+vleaMQWMGfi9q86l2Jirk2JA
         YPmA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=Pq9U2Wtg;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=Pq9U2Wtg;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH v3 1/3] power: supply: Add support for the Qualcomm
 Battery Monitoring System
To: Craig Tatlor <ctatlor97@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180407135934.26122-1-ctatlor97@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d33902cb-65d8-9790-7950-e30134f68578@infradead.org>
Date: Sat, 7 Apr 2018 09:37:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180407135934.26122-1-ctatlor97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597095374964030475?=
X-GMAIL-MSGID: =?utf-8?q?1597106078289479142?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/07/2018 06:59 AM, Craig Tatlor wrote:
> This patch adds a driver for the BMS (Battery Monitoring System)
> block of the PM8941 PMIC, it uses a lookup table defined in the
> device tree to generate a capacity from the BMS supplied OCV, it
> then ammends the coulomb counter to that to increase the accuracy
> of the estimated capacity.
> 
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> ---
>  drivers/power/supply/Kconfig    |   9 +
>  drivers/power/supply/Makefile   |   1 +
>  drivers/power/supply/qcom_bms.c | 500 ++++++++++++++++++++++++++++++++
>  3 files changed, 510 insertions(+)
>  create mode 100644 drivers/power/supply/qcom_bms.c

> diff --git a/drivers/power/supply/qcom_bms.c b/drivers/power/supply/qcom_bms.c
> new file mode 100644
> index 000000000000..5aa6e906d1b9
> --- /dev/null
> +++ b/drivers/power/supply/qcom_bms.c
> @@ -0,0 +1,500 @@

Hi,

> +static unsigned int between(int left, int right, int val)
> +{
> +	if (left <= val && val >= right)

maybe double-check those if() conditions?
[or I need my morning coffee]

> +		return 1;
> +
> +	return 0;
> +}

thanks,
-- 
~Randy
