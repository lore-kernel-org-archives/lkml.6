Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161718AbeCAUmn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 15:42:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60748 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1161633AbeCAUml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 15:42:41 -0500
Subject: Re: [PATCH v2 13/15] KVM: s390: Configure the guest's CRYCB
To: David Hildenbrand <david@redhat.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1519741693-17440-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1519741693-17440-14-git-send-email-akrowiak@linux.vnet.ibm.com>
 <99b24fc7-3df9-6620-d1df-917214fbdda2@redhat.com>
 <fdb264da-dd74-f380-78dc-7abc61f1484b@linux.vnet.ibm.com>
 <081eab40-0bbd-5842-76bc-2974f4544529@redhat.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Thu, 1 Mar 2018 15:42:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <081eab40-0bbd-5842-76bc-2974f4544529@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18030120-8235-0000-0000-00000D197D85
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008609; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00996944; UDB=6.00506878; IPR=6.00776263;
 MB=3.00019805; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-01 20:42:39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030120-8236-0000-0000-00003FE3E419
Message-Id: <4763e223-1c78-c9a3-42bc-2d3569a716ff@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803010253
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2018 04:37 AM, David Hildenbrand wrote:
> On 28.02.2018 21:45, Tony Krowiak wrote:
>> On 02/28/2018 04:49 AM, David Hildenbrand wrote:
>>>> +static int vfio_ap_mdev_open(struct mdev_device *mdev)
>>>> +{
>>>> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>>>> +	unsigned long events;
>>>> +	int ret;
>>>> +
>>>> +	matrix_mdev->group_notifier.notifier_call = vfio_ap_mdev_group_notifier;
>>>> +	events = VFIO_GROUP_NOTIFY_SET_KVM;
>>>> +	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>>>> +				     &events, &matrix_mdev->group_notifier);
>>>> +
>>>> +	ret = kvm_ap_configure_matrix(matrix_mdev->kvm,
>>>> +				      matrix_mdev->matrix);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	ret = kvm_ap_enable_ie_mode(matrix_mdev->kvm);
>>> Can't this happen while the guest is already running? Or what hinders us
>>> from doing that?
>> I'm not sure exactly what you're asking here. Are you asking if the
>> vfio_ap_mdev_open()
>> function can be called multiple times while the guest is running? AFAIK
>> this will be
>> called only once when the mediated device's file descriptor is opened.
>> This happens in
>> QEMU when the -device vfio-ap device is realized.
> Okay, but from a pure interface point of view, this could happen any
> time, even while the guest is already running. Patching in the SCB of a
> running VCPU is evil.
How can this happen while the guest is running? QEMU opens the fd when the
device is realized and AFAIK vfio mdev will not allow any other process to
open it until the guest is terminated. What am I missing?
>
> But I guess we don't have to worry about that when changing they way we
> set ECA_APIE, as described in the other mail.
>
