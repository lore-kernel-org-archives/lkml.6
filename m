Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751860AbeEJSlL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 14:41:11 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:37385 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbeEJSlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 14:41:10 -0400
X-Google-Smtp-Source: AB8JxZo2hR3qRy32vwU7HV0X9pEgzx6qY7+7JzSgnJeJSOUsTE1TyEkEyXBm0PZu9UGdfMkl5cdhIh+9dUCK2VK14J0=
MIME-Version: 1.0
In-Reply-To: <2cb62de4-f8be-e3cf-f415-54de60bb669e@linaro.org>
References: <20180505202450.26630-1-malat@debian.org> <20180509185724.24079-1-malat@debian.org>
 <2cb62de4-f8be-e3cf-f415-54de60bb669e@linaro.org>
From: Mathieu Malaterre <malat@debian.org>
Date: Thu, 10 May 2018 20:40:49 +0200
X-Google-Sender-Auth: RkKPLrwKSvpgxOLBNQ9VQ0BC7mI
Message-ID: <CA+7wUsxf8FNQaTe4ed9vqbdkms1Y8bL5c86MrFm88My28cdtNg@mail.gmail.com>
Subject: Re: [PATCH v2] nvmem: properly handle returned value nvmem_reg_read
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4AIfIps003860

On Thu, May 10, 2018 at 11:58 AM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
> On 09/05/18 19:57, Mathieu Malaterre wrote:
>>
>> Function nvmem_reg_read can return a non zero value indicating an error.
>> This returned value must be read and error propagated to
>> nvmem_cell_prepare_write_buffer. Silence the following gcc warning (W=1):
>>
>>    drivers/nvmem/core.c:1093:9: warning: variable ‘rc’ set but not used
>> [-Wunused-but-set-variable]
>>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>> ---
>> v2: prefer ERR_PTR(-EINVAL) over a simple return NULL
>>
>>   drivers/nvmem/core.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>> index b05aa8e81303..f7b6c85cf393 100644
>> --- a/drivers/nvmem/core.c
>> +++ b/drivers/nvmem/core.c
>> @@ -1107,6 +1107,8 @@ static void *nvmem_cell_prepare_write_buffer(struct
>> nvmem_cell *cell,
>>                 /* setup the first byte with lsb bits from nvmem */
>>                 rc = nvmem_reg_read(nvmem, cell->offset, &v, 1);
>> +               if (rc)
>> +                       goto err;
>>                 *b++ |= GENMASK(bit_offset - 1, 0) & v;
>>                 /* setup rest of the byte if any */
>> @@ -1125,11 +1127,16 @@ static void
>> *nvmem_cell_prepare_write_buffer(struct nvmem_cell *cell,
>>                 /* setup the last byte with msb bits from nvmem */
>>                 rc = nvmem_reg_read(nvmem,
>>                                     cell->offset + cell->bytes - 1, &v,
>> 1);
>> +               if (rc)
>> +                       goto err;
>>                 *p |= GENMASK(7, (nbits + bit_offset) % BITS_PER_BYTE) &
>> v;
>>         }
>>         return buf;
>> +err:
>> +       kfree(buf);
>> +       return ERR_PTR(-EINVAL);
>
> You should return ERR_PTR(rc) not EINVAL here.
> errors should always propagate to caller!

third time's a charm ?

Sorry about this, I was not paying attention.

> thanks,
> srini
>>
>>   }
>>     /**
>>
>
