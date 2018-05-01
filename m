Return-Path: <hdegoede@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525168482; cv=none;
        d=google.com; s=arc-20160816;
        b=VMqzuC4N2SR35+lZ/2BmmNZZoJTPj37uhG+1Rj6fENbu72VNoQ8tPHQhrH62NRBTvW
         RjHqD1nG64szm/mIolr9gKAuCSLamYfYZZhUcZVFVewG7JtmIazYma2sU9qypgyiJ6fa
         VwdGqQFYvciZXt+tXuD7z2tBbAnz3OvK1ouZfmrV0jCXWB/ifcnx+mtqBz5MjInI7txX
         kv8LHk1mjk7obaa9jYaAvvtgb95nO2HwL+0e/yG6Ckth+KSKYIykpEnXRr3WCsNdXClP
         xPQQEugwuYk7B0lKs4xTCmqnBL1BLjfhMhoD6HU2J47x5n3IoJ7RzPw1boNgCtX2GWq6
         5/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=FZJLhXLBMFmphhfDvTNBaZN05HcVx1E+LnNrcIlfwbc=;
        b=FMmaQ+x57u9hcxWQAOYxzGeEzoxlaJ0hYxtCbiyzQc7CERQKpDOuGn3p9m0EKs8nNm
         gi1ROw5RviVVE9raf3oilaATCpmhOHtTcFZZ+tJ++tBbPIDcsjYk5tdPjuzLZOMmZFJk
         4CHRTTLhnbfgIvQ1asB6erKBOyKCWM9SsKqB/T4FIxlcGVfIPk17DTUmw7BZRian8XA/
         EnQfGW+hqzevTROvCgH4/e0qkrPdOlCSBvvYIAEerG/dYmr8FHzGorVFB7mKQJrPRtQp
         wbILvc4eUvcXMfrQJwRTmS+hWGtf7lwJuZAX93OQotVU91Jd/MxcOmAD9w3Xa4zlUWH0
         1Hww==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AB8JxZrz+Xg4klXOaJPayMNmu5LyaL0l/01c2IQAiqkTbbcX898D1ZhN5mOp3mN7Jqr5jEa9/KERMw==
Subject: Re: [PATCH 2/4] usb: typec: tcpm: Release the role mux when exiting
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20180430124158.45269-1-heikki.krogerus@linux.intel.com>
 <20180430124158.45269-3-heikki.krogerus@linux.intel.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <26404d4d-af38-ecf7-ae21-80bb23a4749a@redhat.com>
Date: Tue, 1 May 2018 11:54:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430124158.45269-3-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599175000832404757?=
X-GMAIL-MSGID: =?utf-8?q?1599255066874154578?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 30-04-18 14:41, Heikki Krogerus wrote:
> The ref count for the USB role switch device must be
> released after we are done using the switch.
> 
> Fixes: c6962c29729c ("usb: typec: tcpm: Set USB role switch to device mode when configured as such")
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Makes sense:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>   drivers/usb/typec/tcpm.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> index 1ee259bc14a5..66dc0773b9bf 100644
> --- a/drivers/usb/typec/tcpm.c
> +++ b/drivers/usb/typec/tcpm.c
> @@ -4652,6 +4652,7 @@ void tcpm_unregister_port(struct tcpm_port *port)
>   	for (i = 0; i < ARRAY_SIZE(port->port_altmode); i++)
>   		typec_unregister_altmode(port->port_altmode[i]);
>   	typec_unregister_port(port->typec_port);
> +	usb_role_switch_put(port->role_sw);
>   	tcpm_debugfs_exit(port);
>   	destroy_workqueue(port->wq);
>   }
> 
