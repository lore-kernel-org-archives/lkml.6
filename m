Return-Path: <amit.pundir@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524477769; cv=none;
        d=google.com; s=arc-20160816;
        b=IYdc10bv6ZXwUx9mqCDoHg7IRRf+SiKB7lfClakcNCcaGK3Gu23yE1XNAhyHguO/UM
         dbp8iWNDo2+fj+VmqP89RwfaxXQtKBzOo2PiXNMbi8nuhnE9fKWLrah+lJ6LB5JqRTyI
         J45TIRGcSBu8bnjv9GRJvLkxxGghJXl50ISC7Rtx5o+Z3knqCn3CGzi/HUcGPm+nrInM
         EnIFURrTuOCVcZ5TMXuMJOpmnoSjVC5+HHaJ/rKWpi1t0dlmlu9Ir4X16d2oussZYsjG
         C3JgFBn5Np8Ce7OIlAi9pghqCmyJUkvqlbTXNDA3D2AScH/dE/deSVFN6nMNB88dfc8T
         QR3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=f4pfV6h3J7fxLdhRrDblWPXHB/96AeAwQ1V/bbl99bw=;
        b=MVmur7dLeBfVQBuwdQ4GKUY2WcCe1QFVGL2VpfWNkGK6qETgcMqCX5mjnJv33zzKSL
         mmk4Mltgt7NS2xzhbCzDgmWtSPZs95WifDqvKHIjsIjLEZh5fYuq7iid2AmLs1ePAc58
         Zn07l2o6RUT9YCSAkcPbZBteeafMrIcp+Ts7oRme8h5feQU9N4vdO2CkEre4qlsJI7s8
         UXkoJOxVX1pcTbTBYxEQSXtwslskCK2hTnp1fpkhxY2apFGEc+zNfH7awkh3gWJwtP3w
         OEwIE2MyoEDc5LCSK92OcqQrtD+16m1XZtUGtSWTWG49S0emnD5b5U8QTtidy1nUNYSG
         kjnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=TgJ5ZQDL;
       spf=pass (google.com: domain of amit.pundir@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=amit.pundir@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=TgJ5ZQDL;
       spf=pass (google.com: domain of amit.pundir@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=amit.pundir@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpUyH/FBdp27CiKEA2PaMa3rSKJJEN/cZY7Utocot6v9h9L4yAeGOdXZM/AuNvctH5TSmGP/xPCucHuJgWmIbw=
MIME-Version: 1.0
In-Reply-To: <20180423091631.GA14322@kroah.com>
References: <1524045904-7005-1-git-send-email-amit.pundir@linaro.org>
 <1524045904-7005-5-git-send-email-amit.pundir@linaro.org> <20180423091631.GA14322@kroah.com>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Mon, 23 Apr 2018 15:32:08 +0530
Message-ID: <CAMi1Hd24-Oc90CjyYrq2BRZD6S1fyZKDSVLTt1W68m7=cuKK=A@mail.gmail.com>
Subject: Re: [RESEND][PATCH 4/4] NFC: fdp: Fix possible buffer overflow in
 WCS4000 NFC driver
To: Greg KH <gregkh@linuxfoundation.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org,
	Samuel Ortiz <sameo@linux.intel.com>, Christophe Ricard <christophe.ricard@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, John Stultz <john.stultz@linaro.org>,
	Dmitry Shmidt <dimitrysh@google.com>, Todd Kjos <tkjos@google.com>,
	Android Kernel Team <kernel-team@android.com>, Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598077982406018192?=
X-GMAIL-MSGID: =?utf-8?q?1598530801618383129?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 23 April 2018 at 14:46, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Wed, Apr 18, 2018 at 03:35:04PM +0530, Amit Pundir wrote:
>> From: Suren Baghdasaryan <surenb@google.com>
>>
>> Possible buffer overflow when reading next_read_size bytes into
>> tmp buffer after next_read_size was extracted from a previous packet.
>>
>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
>> ---
>>  drivers/nfc/fdp/i2c.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/nfc/fdp/i2c.c b/drivers/nfc/fdp/i2c.c
>> index c4da50e07bbc..08a4f82a2965 100644
>> --- a/drivers/nfc/fdp/i2c.c
>> +++ b/drivers/nfc/fdp/i2c.c
>> @@ -176,6 +176,16 @@ static int fdp_nci_i2c_read(struct fdp_i2c_phy *phy, struct sk_buff **skb)
>>               /* Packet that contains a length */
>>               if (tmp[0] == 0 && tmp[1] == 0) {
>>                       phy->next_read_size = (tmp[2] << 8) + tmp[3] + 3;
>> +                     /*
>> +                      * Ensure next_read_size does not exceed sizeof(tmp)
>> +                      * for reading that many bytes during next iteration
>> +                      */
>> +                     if (phy->next_read_size > FDP_NCI_I2C_MAX_PAYLOAD) {
>> +                             dev_dbg(&client->dev, "%s: corrupted packet\n",
>> +                                     __func__);
>
> As Andy points out, no need for __func__ in any dev_dbg() call.

Hi, Yes i'm working on v2 of this patch and on the comments I got on
another patch in this series.

Thanks,
Amit Pundir

>
> thanks,
>
> greg k-h
