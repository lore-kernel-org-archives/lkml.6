Return-Path: <mr.nuke.me@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524935270; cv=none;
        d=google.com; s=arc-20160816;
        b=p3ME28Bu1ePUSqZzBa62X9QKOWx/uhl3WT9Q6vhjGs48tNFfpnVWy6NQ42HDaPz2TM
         hEd85rUZ1ZVoWC1v3C5aTihZJy1i8cmu47V4Euz2g+fHpglIPo12Gezv6xmHZscOy4TE
         HdlrXRc3A7+mTzWS+YspCFq85LJ916iDNHYIpWoJKl9XBcQOGCI7nsAB8qtFvazbqNKm
         /9c9jvGGpcQolj+4ZfAJrJJ+4zCNvXr/RBLIfCZaY/7MDMRjRwdUbTy3kom7McWL0VYJ
         2gm+g32SzWZh/v6g/mvY5UD3HSemQ/QRcWiCTuY+Be9kP3EaMigYK8bmddTX2Uroasj9
         RkdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :dkim-signature:arc-authentication-results;
        bh=CIDt2qv51r1bOItDlc5RhNE/7LKYSVmAu+YovgAOfW8=;
        b=PT6UfAUR0fa9J9JYC5f6IM9HJ4jsN/GspHHxr08E5gn/YYPP2DHFG0rM1vNbtddwGA
         A9MfY7kg+GiaMHYIij16C+TWfJjNmldgce1ELpSUozGIMfHTlK6blg/TNZkuNGSi/kMY
         RvvqbObXsHm10cgK9E3Jt22WgDIiMr7asgo6SYe8RII11La5d1QwOYAWyCc2A1r3JS3F
         dezTDJ7wz9f8JBBoWJacJqMBtdE/K4HpJ8TX++KGfgqsFj+3DiVPptCXCwVPY/m8pqs9
         xKoffNlTjZjcBuPxgEDDEzDZoMRSF0p3Nslh7ylUo48IQExkzJ3wtetrUwDWzvRwKT8q
         kigQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QvHYu8AE;
       spf=pass (google.com: domain of mr.nuke.me@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mr.nuke.me@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QvHYu8AE;
       spf=pass (google.com: domain of mr.nuke.me@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mr.nuke.me@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZoI8RZBNWzXH8rHWRlWZIdiE0HLf77Nn3MsxikUbPehiZltqh1n/QqS9ur9DaUE27xghOQAbw==
Subject: Re: [PATCH RESEND] PCI/AER: Use a common function to print AER error
 bits
From: "Alex G." <mr.nuke.me@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 gregkh@linuxfoundation.org, fred@fredlawl.com, linux-kernel@vger.kernel.org,
 alex_gagniuc@dellteam.com, austin_bolen@dell.com, keith.busch@intel.com
References: <20180417170943.1767-1-mr.nuke.me@gmail.com>
 <20180427224337.GC73256@bhelgaas-glaptop.roam.corp.google.com>
 <12343e44-2d8a-51e1-a0be-e6804e9bd8a3@gmail.com>
Message-ID: <220bb125-b933-abf3-7b30-63446634e8d6@gmail.com>
Date: Sat, 28 Apr 2018 12:07:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <12343e44-2d8a-51e1-a0be-e6804e9bd8a3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598014086120567687?=
X-GMAIL-MSGID: =?utf-8?q?1599010525573648977?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/28/2018 11:46 AM, Alex G. wrote:
> On 04/27/2018 05:43 PM, Bjorn Helgaas wrote:
>> On Tue, Apr 17, 2018 at 12:09:43PM -0500, Alexandru Gagniuc wrote:
(snip)
>>> +    memset(&info, 0, sizeof(info));
>>> +    info.severity = aer_severity;
>>> +    info.status = status;
>>> +    info.mask = mask;
>>> +    info.first_error = 0x1f;
>>
>> I like this patch a lot, but where does this "first_error = 0x1f" come
>> from?
> 
> aer_(un)correctable_error_string don't go to [0x1f], so this guarantees 
> us we don't print "(First)".
> 
>> I assume this is supposed to be the "First Error Pointer" in the
>> Advanced Error Capabilities and Control register (PCIe r4.0, sec
>> 7.8.4.7).  There is a "cap_control" field in struct
>> aer_capability_regs; should we be using that here?
> 
> There is a way to extract it from the PCI regs, and it's quite simple. 
> IIRC, it should be all f's when the capability is not implemented. I 
> wanted to avoid any further parsing of PCI regs in this patch.

I could update the offending line to say:
  +	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);

Though I still have the concerns with validating CPER data:

> I can see a way to use even more common printk code, but that requires 
> validating the PCI regs we get from firmware. That means we need to make 
> a guarantee about CPER that is beyond the scope of this patch.
> 
> Alex
> 
