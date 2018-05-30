Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932512AbeE3Xy6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 19:54:58 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44545 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932091AbeE3Xyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 19:54:53 -0400
X-Google-Smtp-Source: ADUXVKJsczUeUbMYbRRZaAahZksrR8SYJTocYeJlqgdt1wV0IBkoxv5eqwr00LqvNdqy98POyrMy4gVKr9b/4CKE5u8=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <85d2a40a-884c-c63d-50f6-024f7bbea4a8@linux.vnet.ibm.com>
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
 <15281606.YptaXzsEVL@x2> <00f66ee1-7494-8249-f148-688616deca0c@linux.vnet.ibm.com>
 <3607733.4k8ofLVAdP@x2> <1160afb4-4184-b30c-5f67-c21536b5f7d3@linux.vnet.ibm.com>
 <CAHC9VhQZeBS3EzgsWogeuCPtGxSFVDm1jUOLV7Jk4JRC4CVLyQ@mail.gmail.com> <85d2a40a-884c-c63d-50f6-024f7bbea4a8@linux.vnet.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 30 May 2018 19:54:51 -0400
Message-ID: <CAHC9VhQrYqK2fTOc5uZeNRx9-RAZSgkuAuW0r1BoHGrpzTyL5A@mail.gmail.com>
Subject: Re: [PATCH 8/8] ima: Differentiate auditing policy rules from "audit" actions
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: Steve Grubb <sgrubb@redhat.com>, zohar@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 5:49 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> On 05/30/2018 05:24 PM, Paul Moore wrote:
>>
>> On Wed, May 30, 2018 at 3:54 PM, Stefan Berger
>> <stefanb@linux.vnet.ibm.com> wrote:
>>>
>>> On 05/30/2018 12:27 PM, Steve Grubb wrote:
>>>>
>>>> On Wednesday, May 30, 2018 11:25:05 AM EDT Stefan Berger wrote:
>>>>>
>>>>> On 05/30/2018 11:15 AM, Steve Grubb wrote:
>>>>>>
>>>>>> On Wednesday, May 30, 2018 9:54:00 AM EDT Stefan Berger wrote:
>>>>>>>
>>>>>>> On 05/29/2018 05:30 PM, Steve Grubb wrote:
>>>>>>>>
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> On Thursday, May 24, 2018 4:11:05 PM EDT Stefan Berger wrote:
>>>>>>>>>
>>>>>>>>> The AUDIT_INTEGRITY_RULE is used for auditing IMA policy rules and
>>>>>>>>> the IMA "audit" policy action.  This patch defines
>>>>>>>>> AUDIT_INTEGRITY_POLICY_RULE to reflect the IMA policy rules.
>>>>>>>>>
>>>>>>>>> With this change we now call integrity_audit_msg_common() to get
>>>>>>>>> common integrity auditing fields. This now produces the following
>>>>>>>>> record when parsing an IMA policy rule:
>>>>>>>>>
>>>>>>>>> type=UNKNOWN[1806] msg=audit(1527004216.690:311):
>>>>>>>>> action=dont_measure
>>>>>>>>> \
>>>>>>>>>
>>>>>>>>> fsmagic=0x9fa0 pid=1613 uid=0 auid=0 ses=2 \
>>>>>>>>> subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 \
>>>>>>>>> op=policy_update cause=parse_rule comm="echo" exe="/usr/bin/echo" \
>>>>>>>>> tty=tty2 res=1
>>>>>>>>
>>>>>>>> Since this is a new event, do you mind moving the tty field to be
>>>>>>>> between
>>>>>>>> auid= and ses=  ?   That is the more natural place for it.
>>>>>>>
>>>>>>> 6/8 refactors the code so that the integrity audit records produced
>>>>>>> by
>>>>>>> IMA follow one format in terms of ordering of the fields, with fields
>>>>>>> like inode optional, though, and AUDIT_INTEGRITY_RULE in the end
>>>>>>> being
>>>>>>> the only one with a different format. Do we really want to change
>>>>>>> that
>>>>>>> order just for 1806?
>>>>>>>
>>>>>>> 5/8 now produces the following:
>>>>>>>
>>>>>>> type=INTEGRITY_PCR msg=audit(1527685075.941:502): pid=2431 \
>>>>>>> uid=0 auid=1000 ses=5 \
>>>>>>> subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 \
>>>>>>> op=invalid_pcr cause=open_writers comm="grep" \
>>>>>>> name="/var/log/audit/audit.log" dev="dm-0" ino=1962494 \
>>>>>>> exe="/usr/bin/grep" tty=pts0 res=1
>>>>>>>
>>>>>>> Comparing the two:
>>>>>>>
>>>>>>> 1806:          action, fsmagic, pid, uid, auid, ses, subj, op, cause,
>>>>>>> comm,    exe, tty, res
>>>>>>> INTEGRITY_PCR:                  pid, uid, auid, ses, subj, op, cause,
>>>>>>> comm, name, dev, ino, exe, tty, res
>>>>>>
>>>>>> OK. I guess go with it as is. It passes testing.
>>>>>
>>>>> What about the position of 'res' field relative to the two new fields
>>>>> 'exe' and 'tty'?
>>>>
>>>> res (results) is always the last field for every event. We have no
>>>> events
>>>> where it is not the last field. I'd prefer to go with it as is. The
>>>> events
>>>> pass my testing the way they are.
>>>>
>>>>> Do we want to keep them as shown or strictly append the
>>>>> two new fields 'exe' and 'tty'?
>>>>
>>>> I'd prefer the first option to keep things as expected.
>>>>
>>>>> Paul seems to request that they appear after 'res'.
>>>>
>>>> I'd rather see them dropped, as useful as they could be, than to malform
>>>> the
>>>> events.
>>>
>>>
>>> Paul NACK'ed them since he wanted to have them added to the end. You seem
>>> to
>>> say it's ok to add them before 'res'. Not sure whether to drop them now
>>> since we are 'at it.'
>>
>> I talked about this in the other patch's thread, but the "new fields
>> at the end of existing records" policy applies here too.
>
>
> I am not sure what to post in v2. It looks like if I append it to the end
> after 'res' I could get the NACK'ed by Steve?!

My apologies, you are getting caught in the middle of this and that
isn't fair to you.

Steve maintains an audit userspace package, I maintain the audit
subsystem in the kernel.  We always try to come to a consensus, but we
sometime reach a "agree to disagree" point and in those cases the
maintainer breaks the tie.  For the purposes of the audit kernel code,
I'm the tie breaker.

There have been a lot of messages spread across the threads, but I
believe Steve's position was that he would prefer to not include new
fields if that meant placing them after the "res" field; combined with
my "new fields at the end of existing records" rule that would mean
the "best" solution would be to simply not add the new fields to the
existing record.  New records do not have these restrictions.

The good news is that Richard's suggestion of associating the record
with other related records should provide most (all?) of the
information that you were trying to log in the first place.

Finally, since you probably haven't followed all of the discussion
around associating records into a single event, I wanted to give you
my side of the story (if you don't care, you can simply skip the rest
of this email).  Currently an audit "event" can consist of multiple
audit "records"; these records can contain PATH information, SYSCALL
information, SELinux AVC information, as well as INTEGRITY_PCR
information.  The current kernel code does a poor job of associating
some of these record types, which can make a single user action look
like multiple audit events.  For example, a single user action/event
(writing a new IMA policy) could result in multiple audit "events"
because the SYSCALL record for the write() syscall is not associated
with the INTEGRITY_POLICY_RULE record; this is bogus because the write
syscall is inherently linked with the IMA policy update.  Keeping the
records as separate audit "events" is not only conceptually odd, it is
misleading.

-- 
paul moore
www.paul-moore.com
