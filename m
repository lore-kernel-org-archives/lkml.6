Return-Path: <kernel-hardening-return-12825-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/oJWumMn+w6nRs3+QfvKE3A33UJi2dmOZXiQbOBANbil4JhA1v6RHWzLfbJNzsNdhoZptX
ARC-Seal: i=1; a=rsa-sha256; t=1522356656; cv=none;
        d=google.com; s=arc-20160816;
        b=bB8CPZ/RBPGFP5rSSRDW85X8RDxGkRpVZ7EIsqvuMxKrq5idqnq88waAuCDGp4lgzG
         W7hiDsHL3H1mPq1usp+ZRR1BnDnMQqVWGQo2ebKeR+ZIXOikg92rpzFPN5JKNCbCMsVj
         Bf2KVXkmT3VD3ccE/rFfkmrG4uDv0eaR0SsxGua0v/Tdg/tfHrKFH1HPrjiJKRX9L8K5
         6jyi+OyOp+KKA5HusHZ8sWOdyHgFPDuCIbE1w/8xqcdUWMJjm78ROGv1dqZojNi+L+eb
         5E8UIxcMLZyoXKRYiA9TDJFhe6KplHwoCi5omDC15JkXu+Uei1V2ddc1ftFNrixQVdby
         4S4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=IgcTJgPTJUzeX7rvNrg7AYyLuyC8PqR2xFSgvhRRDRQ=;
        b=wcrsrulr8q1dBSuDgi5y8xj9SBY/lgRIoaeko3scZjnKyjcqU3B+gJNOHVOVOeeh6l
         a0K2QY6nXq1dlNt5nxefJKML6uqQQ3+Lj4f0r35tdSaqMcWqNbepz40sn6GFxNbDA8tw
         rNDaJ0Iel6+AuH0W2d8hxyH47iSIz48D0sZpV0UU32NZabI25z76J4q3pzw0Vcq2NwGQ
         Ki3ODf3TNXJFguhkOJYZ5puZgVLVbOGIpBzsspiNpLmVK5rsZJbXxdQSUSzFeA9koTHs
         lUaAIjZAkdXHAfUbwY7qzipP+uM5xHvqDLwkXEkmHnTPHXh1+jp0hYdWU/uPeM5Jo/zK
         OQIw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12825-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12825-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12825-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12825-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 29 Mar 2018 14:50:36 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Igor Stoppa <igor.stoppa@gmail.com>
Cc: Igor Stoppa <igor.stoppa@huawei.com>, willy@infradead.org,
 keescook@chromium.org, mhocko@kernel.org, david@fromorbit.com,
 rppt@linux.vnet.ibm.com, labbott@redhat.com,
 linux-security-module@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH v21 0/6] mm: security: ro protection for dynamic
 data
Message-ID: <20180329145036.00155b1e@lwn.net>
In-Reply-To: <5b2a6d5d-5e33-614b-c362-c02a99509def@gmail.com>
References: <20180327153742.17328-1-igor.stoppa@huawei.com>
	<20180327105509.62ec0d4d@lwn.net>
	<5b2a6d5d-5e33-614b-c362-c02a99509def@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596105811324274585?=
X-GMAIL-MSGID: =?utf-8?q?1596306653665507181?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 30 Mar 2018 00:25:22 +0400
Igor Stoppa <igor.stoppa@gmail.com> wrote:

> On 27/03/18 20:55, Jonathan Corbet wrote:
> > On Tue, 27 Mar 2018 18:37:36 +0300
> > Igor Stoppa <igor.stoppa@huawei.com> wrote:
> >   
> >> This patch-set introduces the possibility of protecting memory that has
> >> been allocated dynamically.  
> > 
> > One thing that jumps out at me as I look at the patch set is: you do not
> > include any users of this functionality.  Where do you expect this
> > allocator to be used?  Actually seeing the API in action would be a useful
> > addition, I think.  
> 
> Yes, this is very true.
> Initially I had in mind to use LSM hooks as easy example, but sadly they 
> seem to be in an almost constant flux.
> 
> My real use case is to secure both those and the SELinux policy DB.
> I have said this few times, but it didn't seem to be worth mentioning in 
> the cover letter.

In general, it is quite hard to merge a new API without users to go along
with it.  Among other things, that's how reviewers can see how well the
API works in real-world use.  I am certainly not the one who will make the
decision on whether this goes in, but I suspect that whoever *does* make
that decision would prefer to see some users.

Thanks,

jon
