Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752655AbeDQO1G (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:27:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751230AbeDQO1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:27:05 -0400
Subject: Re: [PATCH v4 03/15] KVM: s390: refactor crypto initialization
To: Cornelia Huck <cohuck@redhat.com>,
        Harald Freudenberger <FREUDE@de.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, alex.williamson@redhat.com,
        alifm@linux.vnet.ibm.com, berrange@redhat.com,
        bjsdjshi@linux.vnet.ibm.com, borntrae@linux.ibm.com,
        fiuczy@linux.vnet.ibm.com, heicars2@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, kvm@vger.kernel.org, kwankhede@nvidia.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        mjrosato@linux.vnet.ibm.com, mschwid2@linux.vnet.ibm.com,
        pasic@linux.vnet.ibm.com, pbonzini@redhat.com,
        Reinhard Buendgen <BUENDGEN@de.ibm.com>, thuth@redhat.com
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1523827345-11600-4-git-send-email-akrowiak@linux.vnet.ibm.com>
 <4fb50a31-1893-5cfb-0f35-fb2501c2afa8@linux.vnet.ibm.com>
 <OFE3FE11B1.8E1BDDEF-ON00258272.002AEDB1-C1258272.002B06EF@notes.na.collabserv.com>
 <20180417121044.5c8f2182.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Tue, 17 Apr 2018 10:26:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180417121044.5c8f2182.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18041714-0040-0000-0000-0000041CDAB3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008870; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01019246; UDB=6.00519964; IPR=6.00798487;
 MB=3.00020614; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-17 14:27:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041714-0041-0000-0000-00000822DF19
Message-Id: <2ac8b862-e2dc-843e-a0b8-906fa32b42f4@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804170129
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/2018 06:10 AM, Cornelia Huck wrote:
> On Tue, 17 Apr 2018 09:49:58 +0200
> "Harald Freudenberger" <FREUDE@de.ibm.com> wrote:
>
>> Didn't we say that when APXA is not available there is no Crypto support
>> for KVM ?
> [Going by the code, as I don't have access to the architecture]
>
> Current status seems to be:
> - setup crycb if facility 76 is available (that's MSAX3, I guess?)

The crycb is set up regardless of whether STFLE.76 (MSAX3) is
installed or not.

> - use format 2 if APXA is available, else use format 1

Use format 0 if MSAX3 is not available
Use format 1 if MSAX3 is available but APXA is not
Use format 2 if MSAX3 and APXA is available

>
>  From Tony's patch description, the goal seems to be:
> - setup crycb even if MSAX3 is not available

Yes, that is true

>
> So my understanding is that we use APXA only to decide on the format of
> the crycb, but provide it in any case?

Yes, that is true

>
> (Not providing a crycb if APXA is not available would be loss of
> functionality, I guess? Deciding not to provide vfio-ap if APXA is not
> available is a different game, of course.)

This would require a change to enabling the CPU model feature for
AP.

>
