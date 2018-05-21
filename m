Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751184AbeEUSaV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 14:30:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34868 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750909AbeEUSaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 14:30:18 -0400
From: Steve Grubb <sgrubb@redhat.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: Richard Guy Briggs <rgb@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, paul@paul-moore.com
Subject: Re: [PATCH] audit: add containerid support for IMA-audit
Date: Mon, 21 May 2018 14:30:18 -0400
Message-ID: <4015765.rtofcNpGHU@x2>
Organization: Red Hat
In-Reply-To: <21646a72-e782-e33a-9e75-5cc98b241f36@linux.vnet.ibm.com>
References: <1520257393.10396.291.camel@linux.vnet.ibm.com> <2397631.78oLu0QVqb@x2> <21646a72-e782-e33a-9e75-5cc98b241f36@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stefan,

On Monday, May 21, 2018 1:53:04 PM EDT Stefan Berger wrote:
> On 05/21/2018 12:58 PM, Steve Grubb wrote:
> > On Thursday, May 17, 2018 10:18:13 AM EDT Stefan Berger wrote:
> >>> audit_log_container_info() then releasing the local context.  This
> >>> version of the record has additional concerns covered here:
> >>> https://github.com/linux-audit/audit-kernel/issues/52
> >> 
> >> Following the discussion there and the concern with breaking user space,
> >> how can we split up the AUDIT_INTEGRITY_RULE that is used in
> >> ima_audit_measurement() and ima_parse_rule(), without 'breaking user
> >> space'?
> >> 
> >> A message produced by ima_parse_rule() looks like this here:
> >> 
> >> type=INTEGRITY_RULE msg=audit(1526566213.870:305): action="dont_measure"
> >> fsmagic="0x9fa0" res=1
> > 
> > Why is action and fsmagic being logged as untrusted strings? Untrusted
> > strings are used when an unprivileged user can affect the contents of the
> > field such as creating a file with space or special characters in the
> > name.
> > 
> > Also, subject and object information is missing. Who loaded this rule?
> > 
> >> in contrast to that an INTEGRITY_PCR record type:
> >> 
> >> type=INTEGRITY_PCR msg=audit(1526566235.193:334): pid=1615 uid=0 auid=0
> >> ses=2 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> >> op="invalid_pcr" cause="open_writers" comm="scp"
> >> name="/var/log/audit/audit.log" dev="dm-0" ino=1962625 res=1
> > 
> > Why is op & cause being logged as an untrusted string? This also has
> > incomplete subject information.
> 
> It's calling audit_log_string() in both cases:
> 
> https://elixir.bootlin.com/linux/latest/source/security/integrity/integrity
> _audit.c#L48

I see. Looking things over, I see that it seems like it should do the right 
thing. But the original purpose for this function is here:

https://elixir.bootlin.com/linux/latest/source/kernel/audit.c#L1944

This is where it is logging an untrusted string and has to decide to encode 
it or just place it in quotes. If it has quotes, that means it's an untrusted 
string but has no control characters in it. I think you want to use 
audit_log_format() for any string that is trustworthy.


As an aside, I wonder why audit_log_string() is in the API when it is a 
helper to audit_log_untrustedstring() ?  Without understanding the rules of 
untrusted strings, it can't be used correctly without re-inventing 
audit_log_untrustedstring() by hand.


> >> Should some of the fields from INTEGRITY_PCR also appear in
> >> INTEGRITY_RULE? If so, which ones?
> > 
> > pid, uid, auid, tty, session, subj, comm, exe, res.  <- these are
> > required to be searchable
> > 
> >> We could probably refactor the current  integrity_audit_message() and
> >> have ima_parse_rule() call into it to get those fields as well. I
> >> suppose adding new fields to it wouldn't be considered breaking user
> >> space?
> > 
> > The audit user space utilities pretty much expects those fields in that
> > order for any IMA originating events. You can add things like op or
> > cause before
>
> We will call into audit_log_task, which will put the parameters into
> correct order:
> 
> auid uid gid ses subj pid comm exe

I'm telling you what the correct order is.  :-)  A long time ago, the IMA 
system had audit events with the order I'm mentioning. For example, here's 
one from a log I collected back in 2013:

type=INTEGRITY_PCR msg=audit(1327409021.813:21): pid=1 uid=0 auid=4294967295 
ses=4294967295 subj=kernel op="add_template_measure" cause="hash_added" 
comm="init" name="01parse-kernel.sh" dev=rootfs ino=5413 res=0

it was missing "tty" and "exe", but the order is as I mentioned. The 
expectation is that INTEGRITY events maintain this established order across 
all events.

Thanks,
-Steve


> https://elixir.bootlin.com/linux/latest/source/kernel/auditsc.c#L2433
> 
> > that. The reason why you can do that is those additional fields are not
> > required to be searchable by common criteria.
> > 
> > -Steve
