Return-Path: <maran.wilson@oracle.com>
X-Google-Smtp-Source: AG47ELuT7du13EbANFPwS5XAsnoGNOHUdFItkDjdcwnpIFqJYBSQZnv30XaQ25CzxMUYaW16TDtp
ARC-Seal: i=1; a=rsa-sha256; t=1519926625; cv=none;
        d=google.com; s=arc-20160816;
        b=Q/YrZ+6ka/coL8uRKtMccFMdf5H8Xf2V4hYhSLhD+4wEXAzeqMO5GVu2gsoZiNyK2J
         5fvaXvX9JZ9D1yyS/v/AwvY3fQzQqsVSkWnkUuqUuq8m86WndPJ1IwmJqL8zySEi+K54
         Bhk86n9ICKYi9+J3VmnfOrS9eV1TkCjKpBmJUUl3ypyHW3rQIsHI1E9jp9W4JPKP4WYO
         qSgqNYoRvHpgsMeRyl90ePluikLv2jIiHYMeITGabbC5NyPhn2zV9OmbCX6qjd5MvvAj
         wN4dA9Gl1UopN06Gk6zQe/ATqf+nuoXqdrPYqia8WaWd5cI4sLScNwZ+du2J/LFK19Vf
         lwDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=PHMzSZopzMAbVOU35APrt5G6pNzEhK+OhifOF+quqiE=;
        b=rHqBKuOlFXu9gHhrl9rnQHUNjHJe1vNr+xH/DLbtmXsHoS/0UsbNZQPvdh/eL6/RQY
         0nP5xE7yLVpHcGy6bKQkL/FeOBNnovr9y3KjXBwED0BiISsIfKWuHGteaG9UivldbKDt
         laIUn592e4SaBYy8zQ0K6wP6qwPwqMZdrKpvtpRWwh7HAwkNQa09ZC8Ym4+VEJ2C6uZX
         cM2Wnp0YnPMr7vWOjebiQ6g1rW81HYH9n1JL86swUOxQnbKwLzMXnpK/UnlMWsjsg8mr
         UveubYqq5EEvOSW2mQ0o3VnD4XZ/JQ9lRyIVi65d2ASV3hfNTny++S9XgsPsZRwYG1sv
         3q/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=U1p6Ynd+;
       spf=pass (google.com: domain of maran.wilson@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=maran.wilson@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=U1p6Ynd+;
       spf=pass (google.com: domain of maran.wilson@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=maran.wilson@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Subject: Re: [RFC PATCH v4 4/7] xen/pvh: Move Xen specific PVH VM
 initialization out of common code
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>, pbonzini@redhat.com,
        jgross@suse.com, roger.pau@citrix.com, andrew.cooper3@citrix.com,
        hch@infradead.org, JBeulich@suse.com, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rkrcmar@redhat.com,
        jpoimboe@redhat.com, bp@suse.de, kirill.shutemov@linux.intel.com,
        thomas.lendacky@amd.com, luto@kernel.org, dave.hansen@linux.intel.com,
        davem@davemloft.net, gregkh@linuxfoundation.org, mchehab@kernel.org,
        linus.walleij@linaro.org, rdunlap@infradead.org
References: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
 <1519842483-8887-5-git-send-email-maran.wilson@oracle.com>
 <d9b1e5ef-af73-d2cb-0f3d-f41cdc8f35cd@oracle.com>
From: Maran Wilson <maran.wilson@oracle.com>
Organization: Oracle Corporation
Message-ID: <2876cbf2-e26a-d6dd-064a-32cf93a9e7ab@oracle.com>
Date: Thu, 1 Mar 2018 09:43:49 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d9b1e5ef-af73-d2cb-0f3d-f41cdc8f35cd@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8819 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803010220
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593670492940069413?=
X-GMAIL-MSGID: =?utf-8?q?1593758580722180955?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/1/2018 8:05 AM, Boris Ostrovsky wrote:
> On 02/28/2018 01:28 PM, Maran Wilson wrote:
>> We need to refactor PVH entry code so that support for other hypervisors
>> like Qemu/KVM can be added more easily.
>>
>> This patch moves the small block of code used for initializing Xen PVH
>> virtual machines into the Xen specific file. This initialization is not
>> going to be needed for Qemu/KVM guests. Moving it out of the common file
>> is going to allow us to compile kernels in the future without CONFIG_XEN
>> that are still capable of being booted as a Qemu/KVM guest via the PVH
>> entry point.
>>
>> Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
>> ---
>>   arch/x86/pvh.c               | 28 ++++++++++++++++++++--------
>>   arch/x86/xen/enlighten_pvh.c | 18 +++++++++++++++++-
>>   2 files changed, 37 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/x86/pvh.c b/arch/x86/pvh.c
>> index b56cb5e7d6ac..2d7a7f4958cb 100644
>> --- a/arch/x86/pvh.c
>> +++ b/arch/x86/pvh.c
>> @@ -72,26 +72,38 @@ static void __init init_pvh_bootparams(void)
>>   	pvh_bootparams.hdr.type_of_loader = (9 << 4) | 0; /* Xen loader */
>>   }
>>   
>> +/*
>> + * If we are trying to boot a Xen PVH guest, it is expected that the kernel
>> + * will have been configured to provide the required override for this routine.
>> + */
>> +void __init __weak xen_pvh_init(void)
>> +{
>> +	xen_raw_printk("Error: Missing xen PVH initialization\n");
> I think this should be printk (or, more precisely, this should not be
> xen_raw_printk()): we are here because we are *not* a Xen guest and so
> Xen-specific printk will not work. (and the same is true for the next
> patch where weak mem_map_via_hcall() is added).

Actually I left that xen_raw_printk() statement in on purpose. It's also 
possible that some future developer accidentally drops or hides the 
strong version of the routine even when CONFIG_XEN (and CONFIG_HVC_XEN) 
is enabled. In that situation, this error message might prove helpful in 
quickly identifying the problem when he or she attempts to boot a Xen guest.

And in situations where CONFIG_XEN is disabled or someone is booting a 
non xen guest, the statement simply becomes a nop, so no harm is done. 
And also, I believe this code is far too early for normal printk() 
statements to work so switching to that won't buy us anything.

Thanks,
-Maran

> -boris
>
>
>> +	BUG();
>> +}
>>
