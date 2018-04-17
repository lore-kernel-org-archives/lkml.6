Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753355AbeDQVzw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 17:55:52 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:36618 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752647AbeDQVzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 17:55:47 -0400
ARC-Authentication-Results: i=1; auth=pass smtp.auth=oleksandr@natalenko.name smtp.mailfrom=oleksandr@natalenko.name
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1524002149; a=rsa-sha256;
        cv=none;
        b=18kalLrfrmTJDV0kKMNoulty636qmvc3ab06b9VV3vkdtFryTtr7UwdgGlG8UI6xXiG3vn4vjVZKDHwk0qmSCZE0/fb29sBT0jtWgmAHdXG0SbS7zcLsMKGF+ZGEz+hxmT895XcbZY9csmGcfiHf2D3k49Hv563YODP/dSd9Sgg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1524002149;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tbFExFNSmGhNbAf/djC4tsJR81sMOO6g8s6uVjEO7dY=;
        b=GvCB4N+Fh1GRoX1UbU50TaZN5KO3nPZ4VnZELKKNBWK+veko41EUZ6Gs6am45aCz3/vuSy
        T22+mXF3uDO693HcUCt/5rxI0T0Ww3tbC7MCqgpJezzKIhdRX/WQpi21TddaJQDSRJMm7n
        5ZUm7QxKz7S+aidu/c2fQY0KQOB0FRo=
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name B598333DDAB
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 17 Apr 2018 23:55:48 +0200
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Kees Cook <keescook@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Valente <paolo.valente@linaro.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        David Windsor <dave@nullcore.net>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>, linux-block@vger.kernel.org,
        keescook@google.com
Subject: Re: usercopy whitelist woe in scsi_sense_cache
In-Reply-To: <CAGXu5j+kHipvoyFWjGp8M6+83zbd6yHOzwxQ-2LNBQbD5-jS9w@mail.gmail.com>
References: <10360653.ov98egbaqx@natalenko.name>
 <CAGXu5j+-PNYxSc3v+QtQLK0S3wdtFthFSxNM_69kFDnPQX0Gaw@mail.gmail.com>
 <CAGXu5j+_UH0h9qeYCKKjhC7jw-mi_=fg4ASHi2=pCF9xGTpA4Q@mail.gmail.com>
 <2864697.7uzmEJovl2@natalenko.name>
 <CAGXu5jLSmJv9AstzsgSscrv-wA7FwfrxAKRxj-FVBmihQvnj1g@mail.gmail.com>
 <CAGXu5j+dh1zm32iBjRVh0s+3gLJYgjwt+z1aBJmrK2Cr8XPWnA@mail.gmail.com>
 <CAGXu5jLhnWnUiscP9B=kTEFNyRw9jgFn7Zr5FxhZrO20553+1Q@mail.gmail.com>
 <CAGXu5jKuZwicyyXH2gB3vp-OjtS+MkG+hqxV1cq1jaG9vAAO=g@mail.gmail.com>
 <CAGXu5jLQuzpjFcfjpT=MvgOxBizFNMjnfmY+E7eCHkDAV5swHg@mail.gmail.com>
 <CAGXu5jJTMqbXia7TmN2yEW11SM+XC3pkMt=bb+xBrY7-OOf=tw@mail.gmail.com>
 <CAGXu5j+xX3kDDS_sPY44hPVb=8isMX-evYzPx3ur=rge1rL5JQ@mail.gmail.com>
 <CAGXu5jJmvKcANUSsCz3fjGSv-tv1hceNd3rOpT4WTfYRb65RRA@mail.gmail.com>
 <8473f909-2123-0cfc-43b1-beba0b1aef9b@kernel.dk>
 <CAGXu5jL9miO3OXpjAxm9t8v=f_f5StB=Tk=aV8BVRdEj-Y-PDA@mail.gmail.com>
 <CAGXu5jKVPQi0cdTbe5Y1DNHdiJ6-kEFRBTNv7znuqT9w5eifGg@mail.gmail.com>
 <07f263ff-cea6-ac3c-944b-0f36fee8ba25@kernel.dk>
 <CAGXu5j+kHipvoyFWjGp8M6+83zbd6yHOzwxQ-2LNBQbD5-jS9w@mail.gmail.com>
Message-ID: <182097a2acc78285019d95d7e750be9e@natalenko.name>
User-Agent: Roundcube Webmail/1.3.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

17.04.2018 23:47, Kees Cook wrote:
> I sent the patch anyway, since it's kind of a robustness improvement,
> I'd hope. If you fix BFQ also, please add:
> 
> Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Root-caused-by: Kees Cook <keescook@chromium.org>
> 
> :) I gotta task-switch to other things!
> 
> Thanks for the pointers, and thank you Oleksandr for providing the 
> reproducer!

That was a great fun to read. Thank you for digging into it.

Regards,
   Oleksandr
