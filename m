Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbeCMHqk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 03:46:40 -0400
Received: from mout.web.de ([212.227.17.11]:43767 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751647AbeCMHqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 03:46:37 -0400
Subject: Re: [3/5] Bluetooth: btmrvl: One check less in
 btmrvl_sdio_card_to_host()
To: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <8d050f76-aed1-7b6b-8778-a78aef34d4ea@users.sourceforge.net>
 <a988a80d-12c0-a414-ab81-ff4ab075855c@users.sourceforge.net>
 <609D1B28-2B75-4AB5-B707-FDB5D0500F1A@holtmann.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <09cd7314-d053-3a6d-a9e1-d666a00ddb55@users.sourceforge.net>
Date: Tue, 13 Mar 2018 08:46:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <609D1B28-2B75-4AB5-B707-FDB5D0500F1A@holtmann.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:BgQ3o6MukFjCCCihBBsIPPbLaL7F1j8m7AKmxRirfnbd6pRBdXe
 QdUC1dTDrbTaQ4NaAjU9RxzH81fP5ugczVR+lphgWd8mrPDTpdjNOPNNPmCTm6UCu6j5AD5
 zZVmDdBIz8SwHOMd70XmgNI2xNlIDDexsVGFwn/kFvkwc68ns9qc4wWF1fU+vrfgasSm5/P
 /wWqUHYKXN0NqSOdCNT6Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZE5hotaex9s=:YqTHt26ypi5QjSy80AYPUO
 hmSSVho4CGTJ1axxddgS3eUS5jfm11pxFEdpztnPrCbhFdHxzOsERqPB2M7UxA4yMJeDaq5SI
 2eKtwieZ91Ty1K+MPjJPP+N7+6PWvmdT8S18O6O6iINo2ser+yAOe99yo3WPtmN3wUAYEy+xc
 i+K6TzRFgQA7k7iKmXGDGXjOuWPIVHZTBYnw36tP5eudocuz7ijBOfAA8tIjmyH8I7AA8MvkC
 ptAiMr40VKPh9s50q5RQ0UrVqeQBEiw4eIa4eznhi6EIBGDV3DZzZystO+ScxvvMsZQcy9tml
 3cCAY1rxAROmmFBtQrXo1QsNO85NAhSbGHbGDKUM2n+Lfo43mom/KG3l/+QYpV8m2J7BERCR5
 1t2wfU6UAc8Z/Uf53QRGidqoC+ansy/caQECMYIyQJTn7oatjaTQ/HNKexHJ69hKt3Kk6YDvN
 QCd+FpLcb4N7SMPiVrfVSnNNugH3vjis4RlFDRox8IlzlmDlAJ3VPazZU7+E0gS0sN+/77ev4
 1aqdWznmhw+caAqNJnJN5vA+b0thkiVEOENE5IRMmrXngTAcMc/m6/ztV7I5SIeVTkDe4m+Ys
 dEMNnne9Gbnoiok/qWoMKcjquvGPoBfPR7NNkOBQ0etDG1ahFJBrvcj4GQJdrOH4JVvgeWHmy
 369UGkYWPryTfI+a53tsULOoyEmM6bbdZrSMv0Ede7W3SvOWfksibWXR+njv1bdUglSTMjqWa
 skJ1IlUcFHmXhUz0v6NZ5zuG76TPCXkhQklJFgJkc63DzF+OivH6FjieSphVjAhH9u2rsV9M4
 DPOkfA5QTcorsukKvIB03sAH35kJCJFiED/D1QKr5cAHAD7AlA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> @@ -797,12 +792,18 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
>> 		break;
>> 	}
>>
>> -exit:
>> -	if (ret) {
>> -		hdev->stat.err_rx++;
>> -		kfree_skb(skb);
>> -	}
>> +	return 0;
>> +
>> +free_skb:
>> +	kfree_skb(skb);
>> +e_io:
>> +	ret = -EIO;
>> +	goto increment_counter;
>>
>> +e_inval:
>> +	ret = -EINVAL;
>> +increment_counter:
>> +	hdev->stat.err_rx++;
>> 	return ret;
> 
> Nope!
> 
> This is not easier to read for me. This goto exit jumping and I hate that.

Can the software design direction become feasible to omit the repeated check
for the variable “ret” (and further initialisations)?

Regards,
Markus
