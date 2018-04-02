Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756566AbeDBS4A (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 14:56:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32924 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756544AbeDBSzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 14:55:55 -0400
Subject: Re: [PATCH v3 04/14] KVM: s390: device attribute to set AP
 interpretive execution
To: Halil Pasic <pasic@linux.vnet.ibm.com>,
        Pierre Morel <pmorel@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com,
        buendgen@de.ibm.com
References: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1521051954-25715-5-git-send-email-akrowiak@linux.vnet.ibm.com>
 <d86ad01e-1c79-c14c-b4da-09d9a31572bd@linux.vnet.ibm.com>
 <21bd029b-3500-3461-ce98-68ad3ae9b647@linux.vnet.ibm.com>
 <46a7e838-2be2-9587-6eb2-3bba95485609@linux.vnet.ibm.com>
 <5ed8017b-0168-9a50-234b-cfe9258eab72@linux.vnet.ibm.com>
 <17683324-f6e4-4328-54c1-1fce572faecd@linux.vnet.ibm.com>
 <8e10f1cb-3722-d231-2603-b7867420ac0a@linux.vnet.ibm.com>
 <5dd1bcd3-5d17-37c1-1184-7f75a1fd32bc@linux.vnet.ibm.com>
 <68e9e3ea-f99a-da88-5e56-21e38b438b4f@linux.vnet.ibm.com>
 <1347ed2e-7bdb-e455-971a-cf60899e3c19@linux.vnet.ibm.com>
 <6c42b3e2-0f32-b84b-ea73-4e99157720d3@linux.vnet.ibm.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Mon, 2 Apr 2018 14:55:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <6c42b3e2-0f32-b84b-ea73-4e99157720d3@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18040218-0056-0000-0000-000004368428
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008790; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01012147; UDB=6.00515819; IPR=6.00791417;
 MB=3.00020378; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-02 18:55:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040218-0057-0000-0000-00000878965B
Message-Id: <b781deb9-5fdc-1809-8e3c-3858e10aa944@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804020206
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/20/2018 06:48 PM, Halil Pasic wrote:
>
> On 03/20/2018 06:58 PM, Tony Krowiak wrote:
>> I spoke with Christian this morning and he made a suggestion which I think would provide the best solution here.
>> This is my proposal:
>> 1. Get rid of the KVM_S390_VM_CRYPTO_INTERPRET_AP device attribute and return to setting ECA.28 from the
>>     mdev device open callback.
>> 2. Since there may be vcpus online at the time the mdev device open is called, we must first take all running vcpus out of
>>     SIE and block them. Christian suggested the kvm_s390_vcpu_block_all(struct kvm *kvm) function will do the trick. So I
>>     propose introducing a function like the following to be called during mdev open:
> There is one thing you missed, otherwise I'm *very* satisfied with this
> proposal.
>
> What you have missed IMHO is vcpu hottplug. So IMHO you should keep
> kvm->arch.crypto.apie, and update it accordingly ...
I agree, I will fix it.
>
>
>>      int kvm_ap_set_interpretive_exec(struct kvm *kvm, bool enable)
>>      {
>>          int i;
>>          struct kvm_vcpu *vcpu;
>>
>>          if (!test_kvm_cpu_feat(kvm, KVM_S390_VM_CPU_FEAT_AP))
>>              return -EOPNOTSUPP;
>>
>>          mutex_lock(&kvm->lock);
>>
>>          kvm_s390_vcpu_block_all(kvm);
> ... let's say here.
Yep
>
>>          kvm_for_each_vcpu(i, vcpu, kvm) {
> And here you can call kvm_s390_vcpu_crypto_setup(vcpu) (the changes to
> this function will be required for hotplug) if you like
Sounds good to me.
>
>>              if (enable)
>>                  vcpu->arch.sie_block->eca |= ECA_APIE;
>>              else
>>                  vcpu->arch.sie_block->eca &= ~ECA_APIE;
> or keep this stuff, it does not really matter to me.
I'll call the kvm_s390_vcpu_crypto_setup(vcpu) to set ECA_APIE.
>
>>          }
>>
>>          kvm_s390_vcpu_unblock_all(kvm);
>>
>>          mutex_unlock(&kvm->lock);
>>
>>          return 0;
>>      }
>>
>>     This interface allows us to set ECA.28 even if vcpus are running
> I tend to agree. I will give it a proper review when this gets more
> formal (e.g. v4 (preferably) or patches to be fixed up to this series).
>
> Please don't forget to revisit the discussion on kvm_s390_vm_set_crypto:
> if the mechanism there isn't right for ECA.28 I think you should tell
> us why it's OK for the other attributes if it's OK. If it is not then
> I guess you will want to do a stand alone patch for that.
That will no longer be a part of this patch series. We can revisit that as
a separate issue at a future time.
>
