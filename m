Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753441AbeEURxO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 13:53:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47294 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753411AbeEURxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 13:53:10 -0400
Subject: Re: [PATCH] audit: add containerid support for IMA-audit
To: Steve Grubb <sgrubb@redhat.com>
Cc: Richard Guy Briggs <rgb@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, paul@paul-moore.com
References: <1520257393.10396.291.camel@linux.vnet.ibm.com>
 <20180308112104.z67wohdvjqemy7wy@madcap2.tricolour.ca>
 <efb6c164-febe-67bb-43a9-795476c4902f@linux.vnet.ibm.com>
 <2397631.78oLu0QVqb@x2>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 21 May 2018 13:53:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2397631.78oLu0QVqb@x2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 18052117-0024-0000-0000-00001873B7C0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009061; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01035630; UDB=6.00529726; IPR=6.00814758;
 MB=3.00021227; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-21 17:53:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052117-0025-0000-0000-00005015F922
Message-Id: <21646a72-e782-e33a-9e75-5cc98b241f36@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-21_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805210211
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/21/2018 12:58 PM, Steve Grubb wrote:
> On Thursday, May 17, 2018 10:18:13 AM EDT Stefan Berger wrote:
>>> audit_log_container_info() then releasing the local context.  This
>>> version of the record has additional concerns covered here:
>>> https://github.com/linux-audit/audit-kernel/issues/52
>> Following the discussion there and the concern with breaking user space,
>> how can we split up the AUDIT_INTEGRITY_RULE that is used in
>> ima_audit_measurement() and ima_parse_rule(), without 'breaking user
>> space'?
>>
>> A message produced by ima_parse_rule() looks like this here:
>>
>> type=INTEGRITY_RULE msg=audit(1526566213.870:305): action="dont_measure"
>> fsmagic="0x9fa0" res=1
> Why is action and fsmagic being logged as untrusted strings? Untrusted
> strings are used when an unprivileged user can affect the contents of the
> field such as creating a file with space or special characters in the name.
>
> Also, subject and object information is missing. Who loaded this rule?
>
>> in contrast to that an INTEGRITY_PCR record type:
>>
>> type=INTEGRITY_PCR msg=audit(1526566235.193:334): pid=1615 uid=0 auid=0
>> ses=2 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
>> op="invalid_pcr" cause="open_writers" comm="scp"
>> name="/var/log/audit/audit.log" dev="dm-0" ino=1962625 res=1
> Why is op & cause being logged as an untrusted string? This also has
> incomplete subject information.

It's calling audit_log_string() in both cases:

https://elixir.bootlin.com/linux/latest/source/security/integrity/integrity_audit.c#L48

>
>> Should some of the fields from INTEGRITY_PCR also appear in
>> INTEGRITY_RULE? If so, which ones?
> pid, uid, auid, tty, session, subj, comm, exe, res.  <- these are required to
> be searchable
>
>> We could probably refactor the current  integrity_audit_message() and have
>> ima_parse_rule() call into it to get those fields as well. I suppose adding
>> new fields to it wouldn't be considered breaking user space?
> The audit user space utilities pretty much expects those fields in that order
> for any IMA originating events. You can add things like op or cause before

We will call into audit_log_task, which will put the parameters into 
correct order:

auid uid gid ses subj pid comm exe

https://elixir.bootlin.com/linux/latest/source/kernel/auditsc.c#L2433




> that. The reason why you can do that is those additional fields are not
> required to be searchable by common criteria.
>
> -Steve
>
>
