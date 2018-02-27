Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751634AbeB0SMc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 13:12:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751126AbeB0SMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 13:12:30 -0500
Subject: Re: [PATCH v2 15/15] s390: doc: detailed specifications for AP
 virtualization
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1519741693-17440-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1519741693-17440-16-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180227165702.67b171db.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Tue, 27 Feb 2018 13:12:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180227165702.67b171db.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18022718-0004-0000-0000-000013BA17F7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995936; UDB=6.00506275; IPR=6.00775260;
 MB=3.00019764; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-27 18:12:28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022718-0005-0000-0000-000086431E01
Message-Id: <d7f95274-5e75-2e82-6294-487e3600d219@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-27_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802270224
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/27/2018 10:57 AM, Cornelia Huck wrote:
> On Tue, 27 Feb 2018 09:28:13 -0500
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> This patch provides documentation describing the AP architecture and
>> design concepts behind the virtualization of AP devices. It also
>> includes an example of how to configure AP devices for exclusive
>> use of KVM guests.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> ---
>>   Documentation/s390/vfio-ap.txt |  514 ++++++++++++++++++++++++++++++++++++++++
>>   MAINTAINERS                    |    1 +
>>   2 files changed, 515 insertions(+), 0 deletions(-)
>>   create mode 100644 Documentation/s390/vfio-ap.txt
>>
>> diff --git a/Documentation/s390/vfio-ap.txt b/Documentation/s390/vfio-ap.txt
>> new file mode 100644
>> index 0000000..c599f30
>> --- /dev/null
>> +++ b/Documentation/s390/vfio-ap.txt
>> @@ -0,0 +1,514 @@
>> +Introduction:
>> +============
>> +The Adjunct Processor (AP) facility is an IBM Z cryptographic facility comprised
>> +of three AP instructions and from 1 up to 256 PCIe cryptographic adapter cards.
>> +The AP devices provide cryptographic functions to all CPUs assigned to a
>> +linux system running in an IBM Z system LPAR.
>> +
>> +The AP adapter cards are exposed via the AP bus. The motivation for vfio-ap
>> +is to make AP cards available to KVM guests using the VFIO mediated device
>> +framework.
> Maybe drop a sentence in here that this makes heavy usage of the s390
> virtualization facilities, which do the heavy lifting?
Will do.
>
>> +
>> +AP Architectural Overview:
>> +=========================
>> +To facilitate the comprehension of the design, let's start with some
>> +definitions:
>> +
>> +* AP adapter
>> +
>> +  An AP adapter is an IBM Z adapter card that can perform cryptographic
>> +  functions. There can be from 0 to 256 adapters assigned to an LPAR. Adapters
>> +  assigned to the LPAR in which a linux host is running will be available to
>> +  the linux host. Each adapter is identified by a number from 0 to 255. When
>> +  installed, an AP adapter is accessed by AP instructions executed by any CPU.
>> +
>> +* AP domain
>> +
>> +  An adapter is partitioned into domains. Each domain can be thought of as
>> +  a set of hardware registers for processing AP instructions. An adapter can
>> +  hold up to 256 domains. Each domain is identified by a number from 0 to 255.
>> +  Domains can be further classified into two types:
>> +
>> +    * Usage domains are domains that can be accessed directly to process AP
>> +      commands
>> +
>> +    * Control domains are domains that are accessed indirectly by AP
>> +      commands sent to a usage domain to control or change the domain, for
>> +      example; to set a secure private key for the domain.
>> +
>> +* AP Queue
>> +
>> +  An AP queue is the means by which an AP command-request message is sent to an
>> +  AP usage domain inside a specific AP. An AP queue is identified by a tuple
>> +  comprised of an AP adapter ID (APID) and an AP queue index (APQI). The
>> +  APQI corresponds to a given usage domain number within the adapter. This tuple
>> +  forms an AP Queue Number (APQN) uniquely identifying an AP queue. AP
>> +  instructions include a field containing the APQN to identify the AP queue to
>> +  which the AP command-request message is to be sent for processing.
>> +
>> +* AP Instructions:
>> +
>> +  There are three AP instructions:
>> +
>> +  * NQAP: to enqueue an AP command-request message to a queue
>> +  * DQAP: to dequeue an AP command-reply message from a queue
>> +  * PQAP: to administer the queues
> Do you also want to explain how these entities show up on the ap bus in
> Linux? It might make the explanations further down easier to
> understand. (Is there any document for the ap bus you could point to?)
I am not aware of any documentation for the AP bus, but I can provide a
few sentences to explain how AP devices are managed by the AP bus.
>
>> +
>> +Start Interpretive Execution (SIE) Instruction:
>> +==============================================
> Call this "AP and SIE" or so? You're not trying to explain the whole
> SIE architecture :)
Okay
>
>
>> +Let's now see how AP instructions are interpreted by the hardware.
> (...)
>
>> +Reserve APQNs for exclusive use of KVM guests
>> +---------------------------------------------
>> +The following block diagram illustrates the mechanism by which APQNs are
>> +reserved:
>> +
>> +                              +------------------+
>> +                 remove       |                  |   unbind
>> +         +------------------->+ cex4queue driver +<-----------+
>> +         |                    |                  |            |
>> +         |                    +------------------+            |
>> +         |                                                    |
>> +         |                                                    |
>> +         |                                                    |
>> ++--------+---------+ register +------------------+      +-----+------+
>> +|                  +<---------+                  | bind |            |
>> +|      ap_bus      |          |  vfio_ap driver  +<-----+    admin   |
>> +|                  +--------->+                  |      |            |
>> ++------------------+  probe   +---+--------+-----+      +------------+
>> +                                  |        |
>> +                           create |        | store APQN
>> +                                  |        |
>> +                                  v        v
>> +                              +---+--------+-----+
>> +                              |                  |
>> +                              |  matrix device   |
>> +                              |                  |
>> +                              +------------------+
>> +
> Thank you for including diagrams, these are really helpful.
You are welcomed
>
> (...)
>
>> +Initialize the CPU model feature for AP
>> +---------------------------------------
>> +This design exploits a feature of the SIE architecture called interpretive
>> +execution (IE). When IE is enabled for a KVM guest, the AP instructions
>> +executed in the guest will be interpreted by the firmware and the commands
>> +contained therein will be passed directly through to an AP device assigned to
>> +the linux host. In order to enable interpretive execution for a KVM guest, SIE
>> +must have access to the AP facilities installed on the linux host. A new CPU
>> +model feature is introduced by this design to indicate that the guest will
>> +directly access the host AP facilities. This feature will be enabled by the
>> +kernel only if the AP facilities are installed on the linux host. This feature
>> +must be turned turned on for the guest in order to ac:
>> +
>> +    /usr/bin/qemu-system-s390x ... -cpu xxx,ap=on
>> +
>> +    Where xxx is the CPU model being used.
>> +
>> +If the CPU model feature is not enabled by the kernel, QEMU
>> +will fail and report that the feature is not supported.
> The cpu model interface is supposed to be user space agnostic, although
> it is only used by QEMU in practice. Mark this as an example more
> clearly?
Will do
>
> (...)
>
> I have not looked at this in detail (will probably come back to this
> later), but this looks like a useful document.
Excellent, I'm glad to hear that. It took some time to put together.
>
