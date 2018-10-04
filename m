Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C98C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 04:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3CA20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 04:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3CA20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeJDKyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 06:54:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726633AbeJDKyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 06:54:22 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w943wnx2092648
        for <linux-kernel@vger.kernel.org>; Thu, 4 Oct 2018 00:03:05 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mwb1nrtd9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 00:03:04 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 4 Oct 2018 05:03:02 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 4 Oct 2018 05:02:57 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9442uAi44433592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Oct 2018 04:02:56 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1173AE056;
        Thu,  4 Oct 2018 07:01:47 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F02E5AE04D;
        Thu,  4 Oct 2018 07:01:45 +0100 (BST)
Received: from localhost.localdomain (unknown [9.80.85.198])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  4 Oct 2018 07:01:45 +0100 (BST)
Subject: Re: [PATCH 1/5] PM / hibernate: Create snapshot keys handler
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jann Horn <jannh@google.com>, joeyli <jlee@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Cc:     joeyli.kernel@gmail.com, rjw@rjwysocki.net,
        Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        yu.c.chen@intel.com, oneukum@suse.com,
        Yu Chen <yu.chen.surf@gmail.com>, ggherdovich@suse.cz
Date:   Thu, 04 Oct 2018 00:02:44 -0400
In-Reply-To: <CAG48ez3=mpJu8gaAZ4-N3pnB-E7d0WkKG8iyD1J=QL4eLwftSQ@mail.gmail.com>
References: <20180912142337.21955-1-jlee@suse.com>
         <20180912142337.21955-2-jlee@suse.com>
         <CAG48ez2pRwpv0V0MNbeBN26isW2peebf+S3cqLxUgdUfARfhiw@mail.gmail.com>
         <20181002075243.GB6040@linux-l9pv.suse>
         <CAG48ez3=mpJu8gaAZ4-N3pnB-E7d0WkKG8iyD1J=QL4eLwftSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18100404-0028-0000-0000-000003023D6A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100404-0029-0000-0000-000023BC76F9
Message-Id: <1538625764.3702.308.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-04_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810040040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-02 at 21:36 +0200, Jann Horn wrote:
> +Andy for opinions on things in write handlers
> +Mimi Zohar as EVM maintainer
> 
> On Tue, Oct 2, 2018 at 9:55 AM joeyli <jlee@suse.com> wrote:
> > On Thu, Sep 13, 2018 at 04:31:18PM +0200, Jann Horn wrote:
> > > On Thu, Sep 13, 2018 at 4:08 PM Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> > > > This patch adds a snapshot keys handler for using the key retention
> > > > service api to create keys for snapshot image encryption and
> > > > authentication.
> > [...snip]
> > > > +static ssize_t disk_kmk_store(struct kobject *kobj, struct kobj_attribute *attr,
> > > > +                             const char *buf, size_t n)
> > > > +{
> > > > +       int error = 0;
> > > > +       char *p;
> > > > +       int len;
> > > > +
> > > > +       if (!capable(CAP_SYS_ADMIN))
> > > > +               return -EPERM;
> > >
> > > This is wrong, you can't use capable() in a write handler. You'd have
> > > to use file_ns_capable(), and I think sysfs currently doesn't give you
> > > a pointer to the struct file.
> > > If you want to do this in a write handler, you'll have to either get
> > > rid of this check or plumb through the cred struct pointer.
> > > Alternatively, you could use some interface that doesn't go through a
> > > write handler.
> > >
> >
> > Thank you for point out this problem.
> >
> > Actually the evm_write_key() is the example for my code. The
> > difference is that evm creates interface file on securityfs, but my
> > implementation is on sysfs:
> >
> > security/integrity/evm/evm_secfs.c
> >
> > static ssize_t evm_write_key(struct file *file, const char __user *buf,
> >                              size_t count, loff_t *ppos)
> > {
> >         int i, ret;
> >
> >         if (!capable(CAP_SYS_ADMIN) || (evm_initialized & EVM_SETUP))
> >                 return -EPERM;
> > ...
> >
> > On the other hand, the writing handler of /sys/power/wake_lock also
> > uses capable() to check the CAP_BLOCK_SUSPEND capability:
> >
> > kernel/power/main.c
> > static ssize_t wake_lock_store(struct kobject *kobj,
> >                                struct kobj_attribute *attr,
> >                                const char *buf, size_t n)
> > {
> >         int error = pm_wake_lock(buf);
> >         return error ? error : n;
> > }
> > power_attr(wake_lock);
> >
> > kernel/power/wakelock.c
> > int pm_wake_lock(const char *buf)
> > {
> > ...
> >         if (!capable(CAP_BLOCK_SUSPEND))
> >                 return -EPERM;
> > ...
> >
> >
> > So I confused for when can capable() be used in sysfs interface? Is
> > capable() only allowed in reading handler? Why the writing handler
> > of securityfs can use capable()?
> 
> They can't, they're all wrong. :P All of these capable() checks in
> write handlers have to be assumed to be ineffective. But it's not a
> big deal because you still need UID 0 to access these files.

Thanks, Jann.  At least EVM should be updated to replace the existing
"capable" check with "if (file_ns_capable(file, &init_user_ns,
CAP_SYS_ADMIN))". 

> 
> > > > +static int user_key_init(void)
> > > > +{
> > > > +       struct user_key_payload *ukp;
> > > > +       struct key *key;
> > > > +       int err = 0;
> > > > +
> > > > +       pr_debug("%s\n", __func__);
> > > > +
> > > > +       /* find out swsusp-key */
> > > > +       key = request_key(&key_type_user, skey.key_name, NULL);
> > >
> > > request_key() looks at current's keyring. That shouldn't happen in a
> > > write handler.
> > >
> >
> > The evm_write_key() also uses request_key() but it's on securityfs. Should
> > I move my sysfs interface to securityfs?
> 
> I don't think you should be doing this in the context of any
> filesystem. If EVM does that, EVM is doing it wrong.

This is being executed in the initramfs before pivoting root.

> 
> > > > +       if (IS_ERR(key)) {
> > > > +               pr_err("Request key error: %ld\n", PTR_ERR(key));
> > > > +               err = PTR_ERR(key);
> > > > +               return err;
> > > > +       }
> > > > +
> > > > +       down_write(&key->sem);
> > > > +       ukp = user_key_payload_locked(key);
> > > > +       if (!ukp) {
> > > > +               /* key was revoked before we acquired its semaphore */
> > > > +               err = -EKEYREVOKED;
> > > > +               goto key_invalid;
> > > > +       }
> > > > +       if (invalid_key(ukp->data, ukp->datalen)) {
> > > > +               err = -EINVAL;
> > > > +               goto key_invalid;
> > > > +       }
> > > > +       skey.key_len = ukp->datalen;
> > > > +       memcpy(skey.key, ukp->data, ukp->datalen);
> > > > +       /* burn the original key contents */
> > > > +       memzero_explicit(ukp->data, ukp->datalen);
> > >
> > > You just zero out the contents of the supplied key? That seems very
> > > unidiomatic for the keys subsystem, and makes me wonder why you're
> > > using the keys subsystem for this in the first place. It doesn't look
> > > like normal use of the keys subsystem.
> > >

Right, evm_write_key() is normally called from the initramfs to signal
the kernel that the EVM encrypted key has been loaded onto root's
keyring.  The decrypted EVM key is then copied to kernel memory.
 Before returning, the decrypted EVM key on root's keyring is cleared.
The initramfs then removes the EVM key from the keyring.

For more details about trusted/encrypted keys refer to
Documentation/security/keys/trusted-encrypted.rst.

Mimi


> > Because I want that only one decrypted key in kernel memory. Then hibernation
> > can handle the key more easy. In evm_init_key(), it also burned the key
> > contents after evm key be initialled:
> >
> > security/integrity/evm/evm_crypto.c
> > int evm_init_key(void)
> > {
> > [...snip]
> >         /* burn the original key contents */
> >         memset(ekp->decrypted_data, 0, ekp->decrypted_datalen);
> >         up_read(&evm_key->sem);
> >         key_put(evm_key);
> >         return rc;
> > }
> >
> > The keys subsystem already handles the interactive with userland and TPM.
> > That's the reason for using keys subsystem in hibernation.
> 
> How do you guarantee that the user is allowed to overwrite that key? I
> don't understand the keys subsystem very well - could this be a key on
> the trusted keyring, or something like that?
> 

