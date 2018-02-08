Return-Path: <b-liu@ti.com>
X-Google-Smtp-Source: AH8x224vx/jW35DHaZKC9wEhy8/lgcgr78U11LVvfPn898WkBsc8AjdasmWsq2iBwed2daxF5JEv
ARC-Seal: i=1; a=rsa-sha256; t=1518057492; cv=none;
        d=google.com; s=arc-20160816;
        b=yXmETSMcgACpRUMYsn5NK2TAbOWb7j3D3v/hTV9PL2aogTBfr9WF6ZJiBlEOpnnaUo
         X6P+DDrmvsAvlk8Qv3uWUsIcqzd2euu2t4IzB5vrtd15KoSYv5y4HD09zpmqs090KYT2
         exmQSqKpMhYxUqOaYB1J6XmBNAGZbZRfRnHy2Tp1rE6q7zQ2rUBhOMVNWLibnvIXNzCi
         8LMLNtKRrDNv+EgoZxN0IWun0gr6rHz5igWh6ZPDOO7SAWmlvhK7BBqM8aCy0cWyiHYf
         l/qyEHJDpYw4lvM707Ez3a4ymJQN+mTlWwGRpWYcKlqCJYjCBCciLvilJztKwEPmRk4r
         gRnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=3odAhgpAhRCOF0oRz3uS1Bo8zML42FGvz4vSoVC8sUA=;
        b=ORsHsraE7qChdxzitoxYngOUpzZgPY7wwMp8LDuR46Y1xw4iYzxAi2of/wsfZc5vO1
         qnm4wKdzB8mnGlOzNp20/sO/CuuWEgES73Niy5WVid7gj+ewbiNuMMW14gRtLmj7hfc/
         CVPm/6Df8MEnyLL1jcRTXxL65FrRZMSUYpLI/oi5TG/f13k6aKTG1hb1aMd156+rlMUh
         +O6q44Zh5UNgzEbkRnR3EFzkeuflO+EANods/vKwqNO6pEhfBiw+1R0PBTwZQcXFRAa8
         iLUSPfbEeRffTZfcZ7pFET++A2PUbq9/HqGLnWWTKvjL+j6laQJcqbmaypox3rb4B7l7
         BpGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=OsdWVE2v;
       spf=pass (google.com: domain of b-liu@ti.com designates 198.47.27.80 as permitted sender) smtp.mailfrom=b-liu@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=OsdWVE2v;
       spf=pass (google.com: domain of b-liu@ti.com designates 198.47.27.80 as permitted sender) smtp.mailfrom=b-liu@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Date: Wed, 7 Feb 2018 20:38:05 -0600
From: Bin Liu <b-liu@ti.com>
To: Maxim Uvarov <muvarov@gmail.com>
CC: Yegor Yefremov <yegorslists@googlemail.com>,
        kernel list
	<linux-kernel@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Greg
 KH <gregkh@linuxfoundation.org>,
        <sergei.shtylyov@cogentembedded.com>,
        Tomas
 Paukrt <tomas.paukrt@advantech-bb.cz>
Subject: Re: [PATCHv2] musb_host: fix lockup on rxcsr_h_error
Message-ID: <20180208023805.GE223@LTA0271908.dhcp.ti.com>
Mail-Followup-To: Bin Liu <b-liu@ti.com>, Maxim Uvarov <muvarov@gmail.com>,
	Yegor Yefremov <yegorslists@googlemail.com>,
	kernel list <linux-kernel@vger.kernel.org>,
	linux-usb <linux-usb@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	sergei.shtylyov@cogentembedded.com,
	Tomas Paukrt <tomas.paukrt@advantech-bb.cz>
References: <20160427212823.GA14645@uda0271908>
 <CAJGZr0JwefevBRxbG_k5jPqf8Bi9ndMMieTcAKfkgCRGcbfjrg@mail.gmail.com>
 <20160428143714.GA7222@uda0271908>
 <CAGm1_ksaa8P1fs03-DSsjvVQu_=cg4yqw7xumb9Gbm+t19O01w@mail.gmail.com>
 <20160503134813.GA690@uda0271908>
 <CAGm1_kvLh-+kJVdtv+7i_1nVsPTQ67uE_5ZizRRfK2iEoWcj+w@mail.gmail.com>
 <20180125154508.GB6590@uda0271908>
 <CAJGZr0+8FRhbMEsKke=DoCAQ7-7gqDKCNJZ+oE==aovqm1kHBw@mail.gmail.com>
 <20180125163146.GD6590@uda0271908>
 <CAJGZr0LcMpdNea+VMZs-0Ln+2ScQK+4oWB95qQFt4uF9V=f9ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJGZr0LcMpdNea+VMZs-0Ln+2ScQK+4oWB95qQFt4uF9V=f9ww@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1532745413883099297?=
X-GMAIL-MSGID: =?utf-8?q?1591798653092488654?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Maxim,

On Fri, Jan 26, 2018 at 12:24:54PM +0300, Maxim Uvarov wrote:
> Bin,
> 
> I looked to my local git and code does not have this latest line "goto
> finish".  It was tested without it and everything worked. Right now I
> can not get access to that hardware to check with and without. But
> only can confirm that without "goto finish" function works with bunch
> of drivers (usb ethernet, hids, hdd).

Thanks for the confirmation. The revert patch has been sent out.

Regards,
-Bin.

> 
> Best regards,
> Maxim.
> 
> 2018-01-25 19:31 GMT+03:00 Bin Liu <b-liu@ti.com>:
> > Maxim,
> >
> > On Thu, Jan 25, 2018 at 07:24:02PM +0300, Maxim Uvarov wrote:
> >> [1] says that issue is with back ported driver to 3.12.10. Can the
> >> latest kernel be tested on the same hw?
> >
> > Agreed that it should be tested with the latest kernel. But my concern
> > now is if stopping scheduling urbs on errors is a right thing to do,
> > that is why I asked if you can re-test your usecase with reverting the
> > commit. I am unable to reproduce the original issue you had.
> >
> > Thanks,
> > -Bin.
> 
> 
> 
> -- 
> Best regards,
> Maxim Uvarov
