Return-Path: <logang@deltatee.com>
X-Google-Smtp-Source: AH8x226AMcLs4o77UVUSzpy7o0oKvdfaR6ZPN5m5VzNFsEz+fUzrfOGVXB4PE+0ZzUzg6jjJd9Xs
ARC-Seal: i=1; a=rsa-sha256; t=1517533856; cv=none;
        d=google.com; s=arc-20160816;
        b=dl6QJK36k7yJC6QsiZGxvimdzJ+klVu7ECcoKicPVr+9fBD6FKlxx+1kKoZvJENuio
         xXXonJF/n9Ubq4oMragjEeCRoPSi+/2Y89wteZqJuGI2JcLn9avMBNRIaWtmzDSJSFrh
         X3ZChPIckdE/jpuvZLlcXeiYLDM+aFFpcqkVXp4eePO7L3+eHvGRP5hJ0zqSO2jqCAfQ
         Yju/gCyE616S47+N9N2pytGE0z52nxAcNeP3BPtGDMzRsSqxBhO8YFJIQji1sPGH3+TG
         yMUYXSx2FQCxYcGF2JWbgukglP+H/DRPoAoH/eqxJCAojNzgLir1utuRVsPzERJgEufI
         wBjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:message-id:from:references:cc:to
         :arc-authentication-results;
        bh=ZVnIYwKPLtMfci1fW52NRhO320icc/A1WOg3i0HBMC0=;
        b=CcySQjMaOQXawhZEOn+fVQWwT71sBo2SQkTCMWRFbYjbWnET3BW2a2naWDAviaO6Hp
         WA1Xf8cwcz1uQQPt4IXVgKuK3gXk0pvqWWPoGCLodLyEc+0V/W/DEmUtCf2EG9wXwE0J
         ou2nnH2CpLVPsN6GqtNg4oF7eukTCjo2D6spqQjuQR7UBBFRa/vx7NgUwo88mDavs4lY
         RKFCovG15q3r3R5wPPW8itc8UqMGzmqr1MZStwtMJa1AD6jP57sxkqbBuCLc9WCPCO+1
         36V0MdcCvVocw7D+odT1kNkoROVj9mFBaSYpAKiCgIz4mnhfmZOEcfHrP56W+SAYfNcP
         jBYg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of logang@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=logang@deltatee.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of logang@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=logang@deltatee.com
To: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>, gregkh@linuxfoundation.org
Cc: axboe@kernel.dk, jlayton@poochiereds.net, bfields@fieldses.org,
 linux-kernel@vger.kernel.org
References: <a01cedbc-ca1a-3e3d-cf2c-3e995c63f793@csail.mit.edu>
 <ce6d8040-3a1e-4137-e7b1-2066b9e56f42@deltatee.com>
 <e23b4d8f-9391-d214-e370-548244339cfb@csail.mit.edu>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c4e3aba6-74ac-f19f-47eb-45484e18630a@deltatee.com>
Date: Thu, 1 Feb 2018 18:10:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e23b4d8f-9391-d214-e370-548244339cfb@csail.mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, bfields@fieldses.org, jlayton@poochiereds.net, axboe@kernel.dk, gregkh@linuxfoundation.org, srivatsa@csail.mit.edu
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: Change in register_blkdev() behavior
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591067494565207085?=
X-GMAIL-MSGID: =?utf-8?q?1591249581059424586?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 01/02/18 05:23 PM, Srivatsa S. Bhat wrote:
> static int find_dynamic_major(void)
> {
>          int i;
>          struct char_device_struct *cd;
> 
>          for (i = ARRAY_SIZE(chrdevs)-1; i > CHRDEV_MAJOR_DYN_END; i--) {
>                                           ^^^^
> As far as I can see, _DYN_END is inclusive, so shouldn't this be >= ?

Yes, it looks like _DYN_END should have been inclusive based on the way 
I documented it.

> 
>                  for (cd = chrdevs[major_to_index(i)]; cd; cd = cd->next)
>                          if (cd->major == i)
>                                  break;
> 
>                  if (cd == NULL || cd->major != i)
>                                       ^^^^^^^^
> It seems that this latter condition is unnecessary, as it will never be
> true. (We'll reach here only if cd == NULL or cd->major == i).

Not quite. chrdevs[] may contain majors that also hit on the hash but 
don't equal 'i'. So the for loop will iterate through all hashes 
matching 'i' and if there is one or more and they all don't match 'i', 
it will fall through the loop and cd will be set to something non-null 
and not equal to i.

Thanks for the review!

Logan
