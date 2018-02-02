Return-Path: <srivatsa@csail.mit.edu>
X-Google-Smtp-Source: AH8x227jHtCgyZBTZoTkTTddW1EgjXUQ+dPf2P0/m4f9VEFLfbiIbwho6l5VAtV2J7pc13yCaUj0
ARC-Seal: i=1; a=rsa-sha256; t=1517537858; cv=none;
        d=google.com; s=arc-20160816;
        b=ukDzhC4DTO49agRfanUdGktEflHDUXkJzzgiIiWPgn+luzAqa943L2QzRmye13rLBY
         n0g6mObZAQSo/pwNnwU/pY5JdDtw+A6rxpOX3UqA0xAz1LslZ4qyl7Czpvma4p/sWlVr
         3KMnlMqWoFC/98glYQcTBDPy7CEXKEufP4ZG7MTlQLYBA2/vUk/kkhOJijO8AOHPoigt
         B1ENS7s085oL8KfqxMJSJjkzrD1BizVRsaYZ9PuapBy9wicH0p0N8q7Jos7V19HvvmO5
         U3kSljpr4SP8cHExiZYPFeepEspaYNJRg2SChdF6nAdF3BIpkwCpRi0/waLxdzeRRYWk
         Yh1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=O2+WYLimuVDlR245zj6igwvbTbscarQ2NlxTFkTV++0=;
        b=aLEtjdRCLnYPCwadpXvdgsa1vbLkfbhdPGMgW4k+Fwv1+k7yP9SeGdsUjiGSEzyCDi
         20MuwdJZFkymsz5t5gCQyl6L/gbV2svAwnLnne+gzCCMTSj81T63yb3+GYiiBvTQSPLO
         2/X4TG/JJqwQFtzu9ovpgtHVPBL1E/B8SQnsqd78KeAw1eIOAl+YAicmN9fadjOKLqsc
         Ei1H52ZjqSh+yWe6Ns94dnAVPBmcB6/Slhb30vO/3THCfbCYVxzBdJLBbwddquTFgtLQ
         LwVSc2U9JIpJjRftzxaAB3iGZ8g+qPz70QaWt680rNnLDCfe31zqD+DPGbZKxOZD5vag
         6Q4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of srivatsa@csail.mit.edu designates 128.30.2.210 as permitted sender) smtp.mailfrom=srivatsa@csail.mit.edu;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=csail.mit.edu
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of srivatsa@csail.mit.edu designates 128.30.2.210 as permitted sender) smtp.mailfrom=srivatsa@csail.mit.edu;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=csail.mit.edu
Subject: Re: Change in register_blkdev() behavior
To: Logan Gunthorpe <logang@deltatee.com>, gregkh@linuxfoundation.org
Cc: axboe@kernel.dk, jlayton@poochiereds.net, bfields@fieldses.org,
 linux-kernel@vger.kernel.org
References: <a01cedbc-ca1a-3e3d-cf2c-3e995c63f793@csail.mit.edu>
 <ce6d8040-3a1e-4137-e7b1-2066b9e56f42@deltatee.com>
 <e23b4d8f-9391-d214-e370-548244339cfb@csail.mit.edu>
 <c4e3aba6-74ac-f19f-47eb-45484e18630a@deltatee.com>
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Message-ID: <b5609789-cc3e-57b9-1848-57b462fe9b0f@csail.mit.edu>
Date: Thu, 1 Feb 2018 18:17:31 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <c4e3aba6-74ac-f19f-47eb-45484e18630a@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591067494565207085?=
X-GMAIL-MSGID: =?utf-8?q?1591253777440760408?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2/1/18 5:10 PM, Logan Gunthorpe wrote:
> 
> 
> On 01/02/18 05:23 PM, Srivatsa S. Bhat wrote:
>> static int find_dynamic_major(void)
>> {
>>          int i;
>>          struct char_device_struct *cd;
>>
>>          for (i = ARRAY_SIZE(chrdevs)-1; i > CHRDEV_MAJOR_DYN_END; i--) {
>>                                           ^^^^
>> As far as I can see, _DYN_END is inclusive, so shouldn't this be >= ?
> 
> Yes, it looks like _DYN_END should have been inclusive based on the way I documented it.
> 

Thank you for confirming! I'll send a patch to fix that (and the analogous
case for CHRDEV_MAJOR_DYN_EXT_END).

>>
>>                  for (cd = chrdevs[major_to_index(i)]; cd; cd = cd->next)
>>                          if (cd->major == i)
>>                                  break;
>>
>>                  if (cd == NULL || cd->major != i)
>>                                       ^^^^^^^^
>> It seems that this latter condition is unnecessary, as it will never be
>> true. (We'll reach here only if cd == NULL or cd->major == i).
> 
> Not quite. chrdevs[] may contain majors that also hit on the hash but don't equal 'i'. So the for loop will iterate through all hashes matching 'i' and if there is one or more and they all don't match 'i', it will fall through the loop and cd will be set to something non-null and not equal to i.
> 

Hmm, the code doesn't appear to be doing that though? The loop's fall
through occurs one past the last entry, when cd == NULL. The only
other way it can exit the loop is if it hits the break statement
(which implies that cd->major == i). So what am I missing?

Regards,
Srivatsa
