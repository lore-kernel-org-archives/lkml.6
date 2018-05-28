Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752838AbeE1Aq3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 20:46:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44598 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752721AbeE1AqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 20:46:25 -0400
From: Stewart Smith <stewart@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, ego@linux.vnet.ibm.com,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpuidle/powernv : init all present cpus for deep states
In-Reply-To: <87fu2gqa9o.fsf@concordia.ellerman.id.au>
References: <1526472134-23757-1-git-send-email-akshay.adiga@linux.vnet.ibm.com> <87fu2gqa9o.fsf@concordia.ellerman.id.au>
Date: Mon, 28 May 2018 10:46:11 +1000
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18052800-0056-0000-0000-000004578E4D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009093; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000262; SDB=6.01038644; UDB=6.00530875; IPR=6.00817772;
 MB=3.00021329; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-28 00:46:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052800-0057-0000-0000-0000089BB016
Message-Id: <87k1ror4j0.fsf@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-27_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805280008
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> writes:
> Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> writes:
>
>> Init all present cpus for deep states instead of "all possible" cpus.
>> Init fails if the possible cpu is gaurded. Resulting in making only
>> non-deep states available for cpuidle/hotplug.
>
> This is basically the opposite of what we just did for IMC.
>
> There we switched from present to possible, to make it work when some
> CPUs are guarded.
>
> Which makes me think we need a better way of dealing with guarded CPUs,
> because working out which code should use present or possible seems to
> be basically trial-and-error.
>
> I'm not actually sure why Guarded CPUs are showing up as possible but
> not present, did we do that on purpose or is it just happening by
> accident?

My guess is that it flows through from firmware putting the guarded out
CPUs in the device tree with a not "okay" status (which, I just
realised, we're putting something in 'status' that isn't what the
current DeviceTree spec says we should... gah -
https://github.com/open-power/skiboot/issues/178 filed for that one).

The idea behind that is that you can answer "where did all my CPUs go?"
by looking at the device tree rather than having to know the platform
specific way of how guards are stored.

-- 
Stewart Smith
OPAL Architect, IBM.
