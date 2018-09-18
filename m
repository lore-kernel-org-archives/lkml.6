Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257C0ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16ED206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D16ED206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbeIRWeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:34:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38280 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729923AbeIRWeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:34:22 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8IGng4x087642
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 13:00:53 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mk4kcjd9m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 13:00:52 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Tue, 18 Sep 2018 18:00:50 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Sep 2018 18:00:46 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8IH0iKp60031098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Sep 2018 17:00:44 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B89A9A4055;
        Tue, 18 Sep 2018 20:00:29 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BAF9A4070;
        Tue, 18 Sep 2018 20:00:29 +0100 (BST)
Received: from oc0155643701.ibm.com (unknown [9.152.224.140])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Sep 2018 20:00:29 +0100 (BST)
Subject: Re: [PATCH v10 11/26] s390: vfio-ap: implement mediated device open
 callback
To:     Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1536781396-13601-12-git-send-email-akrowiak@linux.vnet.ibm.com>
From:   Halil Pasic <pasic@linux.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pasic@linux.ibm.com; prefer-encrypt=mutual; keydata=
 xsFNBFZlVuEBEADbMyhHnvNmxdsJhL5NlGhakJpWDUbmA+xDk4zatQGVeIrs6K/0NEJb+SPZ
 KJQYuud29ZLnDzCN+3lZ+IVy9Ao57llt/xiRyHegn6Nw1q/Sxmczs3n5Trzd+VTSSiqtX1w5
 R07YfAhC9NjNkDTmpC/qdE4ZVfM0ybBra++MzFx3WguHzmmwH7Q5t7nfVr+tHH3+Y12gh52i
 fvpXMeKNItN3dkQ5gpFUVKCQcr5QIEBj+2nYfB2oDCn0LhBcdrUTssz0tR3UZFiXaKiq0O3O
 FR8Y5IxEKcjSe0o1wBwtVnT5XGH0zZZVcoeXSU9AuedUTnbqZoUK7/g2IcRE/9HsQ2yS/Ij8
 oXNqCebOkdZ5iTBnZQGY1PpfJtZlxGuB4Wpl1dN/6BQaufuuJ44QQTeBbOpMdfMoG3qNbYbx
 joYCGgzAo3TIZaMLEwBmjXTPSEkHAgJ0ni+tUqn33XHxCrJzZLVktVOnqWWMwpEQXLA3v6GL
 h5THQNJ22JVGwZde6Hie2mdatxfhm9nX3beg6Bx3j4aZg9JNS1DJsvtozEC2TmRsA/kKyTr0
 cni3qm9le10yG3FPAG2yX3P6CvD6CaZ21yZiiHp3WRMLR/INYw8lR7+UAlPDj9U5IC0hnGFB
 rS9vWQFxy+RNYC97wTrwzDedsyoEkAE/73tXoEOyjydSFaawFQARAQABzSNIYWxpbCBQYXNp
 YyA8aGFsaWwucGFzaWNAZ21haWwuY29tPsLBeAQTAQIAIgUCV+uvjQIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AACgkQDS+G7JcbHQClKhAAiy4hUg9s+BYdiruYFmrMmllfIxEfktD4
 7L8J9SQwTGvCI9keAslc0x8cKAxe1CiTwAc6KHk2FBULXWEjNYLA1VtfGlide7Z4I9REfC0J
 11V4X6CE24QDlsiAZEd63igpCcfRtrPxPN50z7zyoV3Egpd97t+uE0leeeNLQZH7a1hS/Zds
 yCcMXG8iPSxOOtmHJW83PZfNRgorRFsjVh0wbkDptxX5qH4shBigWAuDfw96MZ68BP4Oayz4
 Nw4q7NIQuL4obDIDaaqdAZDQ/pVsitbklt8ZKa5XOOBpHLTxhXmEES0HKMkUTeY2uY0XI7D9
 awgpq/ofz0qbqQyqxveachDXaN7VSZWwiS/HWgiGWZoX8W/Hrzt6MYV6ebzlp4fz7e8bSbin
 Ben39OlIjPIzmzyNi+sbylFhEAHMAb7bSBP2hbnCqZIAzpRBelpRdhkUj4M/KjHHS9pdjkLi
 ohUAMo6Hpez619xZK6UVhgZGFcWnpQ3U/U0gylrPI0+jZRl1x5mx6eO2vr6fDdzkjU1SsYTH
 4/xQay8YODAu+Ld8Ut0xlYKGeAzcqfPFFkMvs/hAeWq+nfT7HK1EIAqRBgnMjvP/Bh1Mys4Y
 4WMMkmdek01JOEsau4K7PoUo65/QCYeHTcwbs8AljpM1OBlXEJ06S34McBkT/NbzU0oXbull
 3L3OwU0EVmVW4QEQAOlv7y30BbbjHDQv4n/jYEjrCiJxs+P1OOUF/KeKWKqhm14nJXXrHlTH
 xcUuqGhEBOnYnSMMhc3LZV1n9uNkAXMrX4uLda6EGrgVTM/bj5Zrj1Gp0q+XFeOD9YPXasDn
 fKsP3agbFBe871sHY4GHlbtYVw4mihBq9FGT4pGlfcf+lM8Gkbb9FjSIW1fxux0ybR4RDXka
 Yc8DF+MUKyfk9oehu+FTLjDI74iPIKj3ZRkWlOzKrGwa3O2jU8mVxu87sACLIiQqdNuO1sop
 CwAd+7bpkVxZVmbkuzNNmH8P9bbHJpGQb+RX8KVEc9U/SyGb024hMXH3Oc9ovOxO2nmjb3cX
 h8Y4cctDEXsbZLmgGKmexeM1tcLflkYFj1idiUunkDJ1loFLifoSrd+zSSSraTpWjApVmVPQ
 sJnOi1X9zmHSFbvMXEtSxacWLP4B04kPVdil3BRwG1E9CDVWrjR6ZgJxQqqCLteIDCQ1e1xc
 Fzl48qtjgbbChegRqpRDEa5dZUgvdADS5xpmSbKyQ8hAN85xih0lJgRj4s5bv98jSUUo+k+Y
 XilJKvsOTexfrhmvtekmkjiOTOFVxXkxQxJVrpmlGM8qWlJuIHmplr3tjADKhNqUEuIGJd/A
 6dtZ/ipTrphJjVhT1JSEKZLQjxJ49ursfuTgYrEfel/4a155EFTVABEBAAHCwV8EGAECAAkF
 AlZlVuECGwwACgkQDS+G7JcbHQAZThAA2zMXgmXzBpVvXRxUlgfgqVS/IHg7YwkxBc6U7I1H
 7oVb90bNXQAzL3MANHvxx2U3ZJOoin7+bQMXRus0J+dyn8sss38oGprOUioB6+dQvFcmQ7/0
 NTcQiITzskxlESEYmZJyaMJno08xSL+gXZyvfPdvFsWVKqQ0N8OXBVcEUOSWOfTqeg2VtjeX
 95JDa9lcnvIJTU2LCZdsNoCPgnvBlE0JJTW9DfiELvE3ghb8uCTxiUD65e2z5jTde0XWvLpz
 v4pTai8ABDMmM26h4Vqo9ffgEkDGC1VhAiJlXyEutm7qb3zI6KbEONBF3SETx73/ixABmJhP
 cBwU9scmmqbcYw+tN2M+XdoyOxIkM50QI+O8BC+zqfBLy91M9Ig8hb5+cv4GB3b75Yh67fOr
 le/UqJOTANw5Ctn7+LaHHeQfHk1hUjE96c4GShxL9ZJMCzXXz/ZgbnfEjuPghFUPLNtqXecu
 KHjQUglVUdAodXMXuShXnSxS19f7LAVGVjNAIUQxAW0BMRfs6CEaaJh//m3cf6yCYf7dFIwE
 5aUp1O+tq+K/bG66jYM9MOnHdO7Z5Kna8YOQY/cZ8qG6QS7aFy3+Afd80Co2PvvCaUr9gqTG
 iBzqRucpjlLTntUQ8nUcqEGUBQ8dGYA7ad0nR3m2ZgWWePUim6UeUrpZH7MHxp2Wfqk=
Date:   Tue, 18 Sep 2018 19:00:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536781396-13601-12-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18091817-0028-0000-0000-000002FAFEAF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091817-0029-0000-0000-000023B4B684
Message-Id: <0ba9647d-76d8-1a6c-bed0-fadd0af496cc@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-18_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809180167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/12/2018 09:43 PM, Tony Krowiak wrote:
> +/**
> + * vfio_ap_mdev_open_once
> + *
> + * @matrix_mdev: a mediated matrix device
> + *
> + * Return 0 if no other mediated matrix device has been opened for the
> + * KVM guest assigned to @matrix_mdev; otherwise, returns an error.
> + */
> +static int vfio_ap_mdev_open_once(struct ap_matrix_mdev *matrix_mdev,
> +				  struct kvm *kvm)
> +{
> +	struct ap_matrix_mdev *m;
> +
> +	mutex_lock(&matrix_dev->lock);
> +
> +	list_for_each_entry(m, &matrix_dev->mdev_list, node) {
> +		if ((m != matrix_mdev) && (m->kvm == kvm)) {
> +			mutex_unlock(&matrix_dev->lock);
> +			return -EPERM;
> +		}
> +	}
> +
> +	mutex_unlock(&matrix_dev->lock);
> +
> +	return 0;
> +}
> +
> +static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
> +				       unsigned long action, void *data)
> +{
> +	int ret;
> +	struct ap_matrix_mdev *matrix_mdev;
> +
> +	if (action != VFIO_GROUP_NOTIFY_SET_KVM)
> +		return NOTIFY_OK;
> +
> +	matrix_mdev = container_of(nb, struct ap_matrix_mdev, group_notifier);
> +
> +	if (!data) {
> +		matrix_mdev->kvm = NULL;
> +		return NOTIFY_OK;
> +	}
> +
> +	ret = vfio_ap_mdev_open_once(matrix_mdev, data);

This could be racy. Two threads doing vfio_ap_mdev_group_notifier()
can first get 0 here in a sense that there is no such kvm in the list,
and then both set the very same kvm three lines below. Which would
result in what we are trying to prevent.

Also vfio_ap_mdev_open_once() does not seem like an appropriate name
any more. If we were to do the matrix_mdev->kvm = kvm in there we could
call it something like vfio_ap_mdev_set_kvm().

> +	if (ret)
> +		return NOTIFY_DONE;
> +
> +	matrix_mdev->kvm = data;
> +
> +	ret = kvm_ap_validate_crypto_setup(matrix_mdev->kvm);
> +	if (ret)
> +		return ret;
> +
> +	vfio_ap_mdev_copy_masks(matrix_mdev);
> +
> +	return NOTIFY_OK;
> +}

