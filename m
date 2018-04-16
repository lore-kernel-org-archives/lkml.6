Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753114AbeDPOvr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 10:51:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36698 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751182AbeDPOvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 10:51:44 -0400
Subject: Re: [PATCH v4 13/15] KVM: s390: configure the guest's AP devices
To: Pierre Morel <pmorel@linux.vnet.ibm.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com,
        buendgen@de.ibm.com
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1523827345-11600-14-git-send-email-akrowiak@linux.vnet.ibm.com>
 <2e7387b9-ceb4-cdca-56ac-f5344084e10a@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 16 Apr 2018 16:51:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2e7387b9-ceb4-cdca-56ac-f5344084e10a@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18041614-0040-0000-0000-0000042F9383
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041614-0041-0000-0000-0000263398CB
Message-Id: <a233848d-9f71-75bc-b720-66d9a54f8185@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-16_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804160139
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/16/2018 03:05 PM, Pierre Morel wrote:
>> +static void vfio_ap_mdev_release(struct mdev_device *mdev)
>> +{
>> +    struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>> +
>> +    kvm_ap_deconfigure_matrix(matrix_mdev->kvm);
>> +    kvm_ap_interpret_instructions(matrix_mdev->kvm, false);
> 
> This call clears the apie in KVM.
> This is only OK if we have a single device present until the end of the VM,
> otherwise AP instructions in the guest will fail after the release until the end of the VM
> or until a new device is plugged.

I agree, this seems wrong.
