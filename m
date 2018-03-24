Return-Path: <aspriel@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521881406; cv=none;
        d=google.com; s=arc-20160816;
        b=bouZDHm2kwKvoxLL29AaxAOZYHgffSCJzjfWBiEgCdK4nipFyVQVaAJIYLm3TGLhqt
         83dy/ILt1HFru60x5PRr13GegvL+WkGI7wfjDcfSeJd0fl8s//7JHTqcTG6sbooRstJX
         9adJg9mA1OGAn0M8lpznCytFzpY7SJLvi+E9J0uqr6e4ARSpWWycZBlmrV57+tCFlKiN
         /tIc00ccT2kOVvBu8FZ2ZEvJ2ombvOX3+HoWEVQWRaiBr3U48NzTSyQxNK3Ka01OidLm
         VpNw6NxOiBQSrpSnXVLC+ZSCDdtBU3ByclzqCJ7Tko8Ao1Thw2VwQFmnkNTSD7WOb6EY
         yF0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=IMuD6tdFlcSnLuy78Kjsw4gKPT5y2VQ49oR6fXdBN+A=;
        b=Lwu/093D4Q3J9iXHD4ccN00xZtTmtJ5FCGZmElVqRxxXLFLjjcpuyKP9+Loz/kJyd5
         uuKgnYlqajVPOVUbLXacttKyhftfICJABhF9aMmo9B3Q5GxYVSADVfKeWim0HKRRx75y
         rKATM8TB60eiv1+ZE9U7da4pyY8Ioqhvqg7Jly9lFhsHsRsA62NzpoZnKK4rzs+5LBph
         4/T13yl6kYpNR3YQHMY21QD88jyCxe7IHpPwsyILjpv9rAfFJqRwqBAtYZYv3XzVGq21
         ZZGyFLId5b2mWSl2SjMawsJfpLpvEtRRv2F2Zs6ohOeinw9p2AS10c4CNT3+WaA8dcRM
         433g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pdgsUZLW;
       spf=pass (google.com: domain of aspriel@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aspriel@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pdgsUZLW;
       spf=pass (google.com: domain of aspriel@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aspriel@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvt8Qk8vs6a/kBAgtRMAMceWjE6uE/yL0zpCGBcC9hSu59mt4QvTm+x1DPQn/6go9OR1TvLB56Vve9rsbfZRQo=
MIME-Version: 1.0
In-Reply-To: <20180323165543.GA21833@kroah.com>
References: <1521107725-25027-1-git-send-email-aspriel@gmail.com>
 <1521107725-25027-3-git-send-email-aspriel@gmail.com> <20180323165543.GA21833@kroah.com>
From: Arend van Spriel <aspriel@gmail.com>
Date: Sat, 24 Mar 2018 09:50:05 +0100
Message-ID: <CAJ65rDy1UjJ7tEu4f3m8BwnA1qai1iRU3yWfU4qvEE9uLrr5pg@mail.gmail.com>
Subject: Re: [PATCH for-4.16 2/3] drivers: change struct device_driver::coredump()
 return type to void
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594997067781625897?=
X-GMAIL-MSGID: =?utf-8?q?1595808317813464103?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 23, 2018 at 5:55 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Thu, Mar 15, 2018 at 10:55:24AM +0100, Arend van Spriel wrote:
>> Upon submitting a patch for mwifiex [1] it was discussed whether this
>> callback function could fail. To keep things simple there is no need
>> for the error code so the driver can do the task synchronous or not
>> without worries. Currently the device driver core already ignores the
>> return value so changing it to void.
>>
>> [1] https://patchwork.kernel.org/patch/10231933/
>>
>> Signed-off-by: Arend van Spriel <aspriel@gmail.com>
>> ---
>>  include/linux/device.h | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/device.h b/include/linux/device.h
>> index b093405..f08c25b 100644
>> --- a/include/linux/device.h
>> +++ b/include/linux/device.h
>> @@ -256,6 +256,9 @@ enum probe_type {
>>   *           automatically.
>>   * @pm:              Power management operations of the device which matched
>>   *           this driver.
>> + * @coredump:        Called when sysfs entry is written to. The device driver
>> + *           is expected to call the dev_coredump API resulting in a
>> + *           uevent.
>>   * @p:               Driver core's private data, no one other than the driver
>>   *           core can touch this.
>>   *
>> @@ -287,7 +290,7 @@ struct device_driver {
>>       const struct attribute_group **groups;
>>
>>       const struct dev_pm_ops *pm;
>> -     int (*coredump) (struct device *dev);
>> +     void (*coredump) (struct device *dev);
>
> Isn't this going to cause build warnings now?  Are there no users of
> this callback function yet?

Hi Greg,

I submitted driver patches for the 4.17 kernel and from that
discussion we concluded it would be good to change to void return
type. So those driver patches were dropped. The caller of the callback
in drivers/base/dd.c does not use the return value so from that side
there is no issue. So my motivation for asking to consider this for
4.16 is so I can resubmit the driver patches for 4.17 if there is
still time before the merge window.

Regards,
Arend
