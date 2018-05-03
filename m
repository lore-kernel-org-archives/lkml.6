Return-Path: <amit.pundir@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525372057; cv=none;
        d=google.com; s=arc-20160816;
        b=ff+obnXLQ6dbGPWuxVG/cpPELbrZ/cp7Qx/ydpGtH07Zry1HZyqDq18cyjyf4QWEeZ
         ijUSdVNHwmW1WsW8GYsdXb4ueY7eRCKLVzapQtNk9u1I81nPGMhSueGO7JyJkT366CmV
         mYbkuxqe3xxmbPOCs0fIb2XLDTgk8bHjkOLWVAuX91cpZ2/cmiePf7P4EjgwNG3T4ST3
         i0D9jw6zCXlWUNvUNbKrWSCKyQEd9EqYPwAIpSe/h4oNqM2xEHUBQFdJQ3QiiA0cDiAo
         B31zj5uSMJCCYLRU8FT0WTCdNFaXvQXJtZb26MQprIsu3pF9Vrq1YzO8dRiSFiHa0dFP
         py3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=5JhSmIha80rvsM71TEKS2B1PHDtBWa9m1AeBDujcKH0=;
        b=BvidAboLngLZ0G8OufVzzmGCs0IdQ8Oz7QA6m4ZsH8Y347sZ7Ab0P6wqHLgTaAVqke
         7K6vVBH5KKcScoBPbG/uilSfQrzOluVjSX3mhDuPApPndoPxlCwykR47A9cx1JMnaktI
         dY/7bNJpBYqJoqf5hqRyDLeIAfPgwjQUY3iHSCncWqFADhknWHIqqgeWof3znJ1ftVe6
         VvdSM7WRLDOuI4/4ZSpGTlNXwvvRd1FGOZIz2JV1XsA6ABiVguAIk1Hequ9xFQnyZWNj
         24mIowsieorF4tp5oZC/S1SYz550sBMGGU9/valYwSBZTcmpI7SRTlsUKg0srhpX1dwV
         ekGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=COHtBq7F;
       spf=pass (google.com: domain of amit.pundir@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=amit.pundir@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=COHtBq7F;
       spf=pass (google.com: domain of amit.pundir@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=amit.pundir@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZrPummDIDm0JxgvrDiP2x/ZL4hZxCTcJdJPvOdabvpxMsvnfugqiqoC27LT94+LQ/kD/mpgzcR6TDUI4KX8X3M=
MIME-Version: 1.0
In-Reply-To: <1525342843.21176.635.camel@linux.intel.com>
References: <1525283288-7027-1-git-send-email-amit.pundir@linaro.org>
 <1525283288-7027-4-git-send-email-amit.pundir@linaro.org> <1525342843.21176.635.camel@linux.intel.com>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Thu, 3 May 2018 23:56:56 +0530
Message-ID: <CAMi1Hd0Tzmp-TPi4nuBEoHgcLPyz=LVVuOY5w52ySrOkY8by6A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] NFC: fdp: Fix possible buffer overflow in WCS4000
 NFC driver
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>, Samuel Ortiz <sameo@linux.intel.com>,
	Christophe Ricard <christophe.ricard@gmail.com>, Greg KH <gregkh@linuxfoundation.org>,
	John Stultz <john.stultz@linaro.org>, Dmitry Shmidt <dimitrysh@google.com>,
	Todd Kjos <tkjos@google.com>, Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599375469996220614?=
X-GMAIL-MSGID: =?utf-8?q?1599468530167812828?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3 May 2018 at 15:50, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Wed, 2018-05-02 at 23:18 +0530, Amit Pundir wrote:
>> From: Suren Baghdasaryan <surenb@google.com>
>>
>> Possible buffer overflow when reading next_read_size bytes into
>> tmp buffer after next_read_size was extracted from a previous packet.
>>
>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
>> ---
>> v2:
>> Remove redundant __func__ from dev_dgb().
>>
>>  drivers/nfc/fdp/i2c.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/nfc/fdp/i2c.c b/drivers/nfc/fdp/i2c.c
>> index c4da50e..b80d1ad 100644
>> --- a/drivers/nfc/fdp/i2c.c
>> +++ b/drivers/nfc/fdp/i2c.c
>> @@ -176,6 +176,15 @@ static int fdp_nci_i2c_read(struct fdp_i2c_phy
>> *phy, struct sk_buff **skb)
>>               /* Packet that contains a length */
>>               if (tmp[0] == 0 && tmp[1] == 0) {
>>                       phy->next_read_size = (tmp[2] << 8) + tmp[3]
>> + 3;
>> +                     /*
>> +                      * Ensure next_read_size does not exceed
>> sizeof(tmp)
>> +                      * for reading that many bytes during next
>> iteration
>> +                      */
>> +                     if (phy->next_read_size >
>> FDP_NCI_I2C_MAX_PAYLOAD) {
>> +                             dev_dbg(&client->dev, "corrupted
>> packet\n");
>
>> +                             phy->next_read_size = 5;
>
> Shouldn't be this magic replaced by
>
>         phy->next_read_size = FDP_NCI_I2C_MIN_PAYLOAD;
>
> ?

Ack. Fixing it in v3.

Regards,
Amit Pundir

>
>> +                             goto flush;
>> +                     }
>>               } else {
>>                       phy->next_read_size =
>> FDP_NCI_I2C_MIN_PAYLOAD;
>>
>
> --
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy
