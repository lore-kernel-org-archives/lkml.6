Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AG47ELuITENZGRvO0u7vDCy62N2rIC+Jx228eP1IA9i4LXkrGMszZtq6Yh37dcg5GRVhySm5MeBn
ARC-Seal: i=1; a=rsa-sha256; t=1520865999; cv=none;
        d=google.com; s=arc-20160816;
        b=hAvEblihmPs0BWbOpOwnqB9j6l+foxBHRyhmO9D73/gkv1sUHuHAz7ntyqTMvPZISW
         MQpWt0nfNnYT9kun31w1HAw609vzAsJIQFhI7QUDNX8Uv3r/kTB4AnLp7+dw47+4e85v
         +iON2CHaaPCSERCLG7a+oufag294q/kV+D+qrXp8Sna8MBuTvfWxMjdoBw5La8yjUndi
         oMSyEJBCZu5i7x+YLH4KvMaDmrAf/N0K7W+4fP4E3JfetRwdJgVDpXBhNY0GkKk/9Q/L
         QDWWNCpC+uLRCRPS+NKjjYDsR/g/2W4A47wUv/4fWKDQ2Szyu0W4ilvJtrsa19/t4a/f
         XOPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:references:in-reply-to:subject:cc:to:from
         :date:content-transfer-encoding:mime-version:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=zp0bwhjZzzCN+MPPtpE9dhnbnBgL6g/zXr7ZdJvKhx4=;
        b=JD4F/9+gD863kkEEq3iYHsTKkltFnHkN5aIhROZ9lcgqbDhhKZhL2fCC6qoqZmSvL3
         FPmlI3oTvFf+U36RMexGTLxyNTsRTGYZrk1ztYB9WdWCoBxgA1QzO2PYoc0ayvhJqMPB
         Auhrv5c15seldwtIG8ifEeZprwmuqhykZpD7AtMALnM1Zkeauul9kbpwIYJeKJnjtHAx
         LWG+bDBPItYo16fR16zco3NbJYyiiUtDmYYcHyIv+jr9NbTEvejus2YReTXZmUFyfBKW
         Fcc/8h1sVg7h941PUDOKh0h823A/wmwmmXIYDBQrtKX3be6+A3DvbRulFcnDh4gi7UNb
         Ot/A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ekROUzHJ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=hBAFzDQ6;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ekROUzHJ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=hBAFzDQ6;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Mar 2018 20:16:38 +0530
From: poza@codeaurora.org
To: Keith Busch <keith.busch@intel.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Wei
 Zhang <wzhang@fb.com>, Timur Tabi <timur@codeaurora.org>,
 linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH v12 0/6] Address error and recovery for AER and DPC
In-Reply-To: <20180312142551.GB18494@localhost.localdomain>
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
 <20180311220337.GA194000@bhelgaas-glaptop.roam.corp.google.com>
 <04ade52e-d1ea-fe67-bb26-246621d159e6@codeaurora.org>
 <20180312142551.GB18494@localhost.localdomain>
Message-ID: <3e1a2036675de6b8456145a022640f3d@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593665102741565714?=
X-GMAIL-MSGID: =?utf-8?q?1594743586600777507?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-03-12 19:55, Keith Busch wrote:
> On Sun, Mar 11, 2018 at 11:03:58PM -0400, Sinan Kaya wrote:
>> On 3/11/2018 6:03 PM, Bjorn Helgaas wrote:
>> > On Wed, Feb 28, 2018 at 10:34:11PM +0530, Oza Pawandeep wrote:
>> 
>> > That difference has been there since the beginning of DPC, so it has
>> > nothing to do with *this* series EXCEPT for the fact that it really
>> > complicates the logic you're adding to reset_link() and
>> > broadcast_error_message().
>> >
>> > We ought to be able to simplify that somehow because the only real
>> > difference between AER and DPC should be that DPC automatically
>> > disables the link and AER does it in software.
>> 
>> I agree this should be possible. Code execution path should be almost
>> identical to fatal error case.
>> 
>> Is there any reason why you went to stop driver path, Keith?
> 
> The fact is the link is truly down during a DPC event. When the link
> is enabled again, you don't know at that point if the device(s) on the
> other side have changed. Calling a driver's error handler for the wrong
> device in an unknown state may have undefined results. Enumerating the
> slot from scratch should be safe, and will assign resources, tune bus
> settings, and bind to the matching driver.
> 
> Per spec, DPC is the recommended way for handling surprise removal
> events and even recommends DPC capable slots *not* set 'Surprise'
> in Slot Capabilities so that removals are always handled by DPC. This
> service driver was developed with that use in mind.

Now it begs the question, that

after DPC trigger

should we enumerate the devices, ?
or
error handling callbacks, followed by stop devices followed by 
enumeration ?
or
error handling callbacks, followed by enumeration ? (no stop devices)

Regards,
Oza.
