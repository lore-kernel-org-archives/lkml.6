Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C06C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 06:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABA9223E8
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 06:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Blmgy7fy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BABA9223E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbeHJJLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 05:11:34 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:44383 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbeHJJLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 05:11:33 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20180810064302epoutp049082ca0091a0d3b4469b1d9313a5c82f~Jcs80N7e61377913779epoutp04v
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 06:43:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180810064302epoutp049082ca0091a0d3b4469b1d9313a5c82f~Jcs80N7e61377913779epoutp04v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533883382;
        bh=itFgbxMwOV/olzqViLJBayc6YObzXBUaPFlwYTiMWII=;
        h=Date:From:Reply-To:To:CC:Subject:In-Reply-To:References:From;
        b=Blmgy7fyVXRS3un+MDzdgoy3TemJGErpRqopI3L3xVAZmUo7uwRgpGem6lG2rCK15
         I3rUvcrflqLhl8aKPhxJUbbY6bkWy1lOmC3MLf/fTnxzwu/l7eAcjTYLnJR0IjcRHZ
         CZ/0Y7d8yQlaKt5IHmE8aVzYlExzOTMD78EvKDdc=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20180810064259epcas1p472275ebef6c10f7acd255bbaac96f63d~Jcs6NAII91970819708epcas1p42;
        Fri, 10 Aug 2018 06:42:59 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        93.4D.04292.2F33D6B5; Fri, 10 Aug 2018 15:42:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20180810064258epcas1p3eb68d29dbd60b705d0473b3c645496ff~Jcs48Q55D0165001650epcas1p3e;
        Fri, 10 Aug 2018 06:42:58 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180810064258epsmtrp218f93c12b95f1a693c4d55f6aa59127d~Jcs46SYzF2227622276epsmtrp2p;
        Fri, 10 Aug 2018 06:42:58 +0000 (GMT)
X-AuditID: b6c32a38-d53ff700000010c4-57-5b6d33f26eaa
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        15.4E.03889.2F33D6B5; Fri, 10 Aug 2018 15:42:58 +0900 (KST)
Received: from [10.113.63.222] (unknown [10.113.63.222]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180810064257epsmtip29c53fbf852485cd2aeeae9eddffc6ee7~Jcs4sWV4j2964429644epsmtip2b;
        Fri, 10 Aug 2018 06:42:57 +0000 (GMT)
Date:   Fri, 10 Aug 2018 15:43:02 +0900
From:   Seung-Woo Kim <sw0312.kim@samsung.com>
Reply-To: sw0312.kim@samsung.com
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:16.0) Gecko/20121011
        Thunderbird/16.0.1
MIME-Version: 1.0
To:     sw0312.kim@samsung.com
CC:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>, lwn@lwn.net,
        Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 3.18.111
In-Reply-To: <20180808100622epcas1p1d4e3d6f858a9de3014f6d79bf284ff2c~I4L612J9p0428204282epcas1p1X@epcas1p1.samsung.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmge4n49xog+07FC3mrF/DZtG8eD2b
        xeffu1gtLu+aw2ax4vB0FosFGx8xWsyY/JLN4lHfW3aL83+PszpwepyY8ZvFY//cNewei/sm
        s3r0bVnF6HFmwRF2j8+b5Dw2PXnLFMAelWqTkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhr
        aGlhrqSQl5ibaqvk4hOg65aZA3SakkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKdrQ0EjP
        0MBcz8gISBvHWhmZApUkpGb0XH7MWrBCuOJsU10D40H+LkZODgkBE4krr1eydDFycQgJ7GCU
        ePD8PzNIQkjgE6PE9ds2EIlvjBKfd+1lhulYuf4bM0RiL6PExTlnoJy3jBIPm+exglSxCKhK
        7L10EayDTUBHYv+S36wQYxUkLmydwQZiiwqEScw42M8IYvMKCEqcnPmEBcQWEZCS+H/oPlg9
        s8BBJol5f1NAbGEBaYkrZzazg9icAuUSn1/+YYaokZdo3job7AgJgd9sEp2Xv7NCDC2T+N3f
        wwRxtovE87frWCBsYYlXx7ewQ9hSEp/f7WWDsNsZJQ7OrIMYNIVR4trfT1BFxhLPFnYBDeIA
        2qYpsX6XPsRiPol3X3tYQcISArwSHW1CENUqEjuPTmKDCEtJzNoQDBH2kGi7sBcaVo9YJFpO
        NLNOYFSYheT9WUjemYWwbAEj8ypGsdSC4tz01GLDAhO94sTc4tK8dL3k/NxNjOA0qmWxg3HP
        OZ9DjAIcjEo8vAypOdFCrIllxZW5hxglOJiVRHj3vAMK8aYkVlalFuXHF5XmpBYfYjQFxtRE
        ZinR5Hxgis8riTc0NTI2NrYwMTQzNTRUEuc18guOFhJITyxJzU5NLUgtgulj4uCUamDsKjog
        vPuM3vxZehM+OZi4LmSzl3h952zP9Xc7Ku7dmmfdvDxhwecg6X3NcyrmJ52Y8WTn6cPRJ1w/
        XZzvoffHJ6u6NTWK5+Df0p/6d5JOO77eILmg7YPw+RaBWULXth4xFp28rv304hblmf1xku94
        BdvKA8znHva60/jnUMrcuOIp1U/rnwVpKbEUZyQaajEXFScCAPADzei5AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LZdlhJXveTcW60waZWFos569ewWTQvXs9m
        8fn3LlaLy7vmsFmsODydxWLBxkeMFjMmv2SzeNT3lt3i/N/jrA6cHidm/Gbx2D93DbvH4r7J
        rB59W1YxepxZcITd4/MmOY9NT94yBbBHcdmkpOZklqUW6dslcGX0XH7MWrBCuOJsU10D40H+
        LkZODgkBE4mV678xdzFycQgJ7GaUWHa4jR0iISUx99t2xi5GDiBbWOLw4WKQsJDAa0aJ1dPV
        QWxeAS2Jrt9XmEFsFgFVib2XLoLZbAI6EvuX/GaFqFeQuLB1BhuILSoQIvHr4xVWiF5BiZMz
        n7CA2CJAq/4fug8WZxY4yiRxeytYvbCAtMSVM5vZIW67wiLxZdlRsNs4BcolPr/8wwxyG7OA
        usT6eUIQvfISzVtnM09gFJqFZMUshKpZSKoWMDKvYpRMLSjOTc8tNiwwykst1ytOzC0uzUvX
        S87P3cQIjh8trR2MJ07EH2IU4GBU4uFlSM2JFmJNLCuuzD3EKMHBrCTCu+cdUIg3JbGyKrUo
        P76oNCe1+BCjNAeLkjivfP6xSCGB9MSS1OzU1ILUIpgsEwenVAOjwqKW+e3+DQyeBRpFfzlP
        uUpwfWM8KOQ1r+dCwpQZ4XndZ+wNJ5cG7HtTtm5jVqVM4Ie2JrF19o+YGc8vd9Gr+XtFt3rR
        4UereBl4Qvb+WMXZpzunTvU3z4mju+sLp05ZzJPybZ70Ba7ms/tTN29cp9K25THfD8ZjWqqn
        a69F7v2WwXhl0o6VSizFGYmGWsxFxYkAtVja6JsCAAA=
Message-Id: <20180810064258epcas1p3eb68d29dbd60b705d0473b3c645496ff~Jcs48Q55D0165001650epcas1p3e@epcas1p3.samsung.com>
X-CMS-MailID: 20180810064258epcas1p3eb68d29dbd60b705d0473b3c645496ff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180530073304epcas3p4967df82d2d086fd08fd354781df61861
References: <CGME20180530073304epcas3p4967df82d2d086fd08fd354781df61861@epcas3p4.samsung.com>
        <20180530073211.GA22422@kroah.com>
        <20180703032456epcas1p29c4570ae3f6bb3f8d7c2d475e1ba4658~9vfIpgNT51989519895epcas1p2d@epcas1p2.samsung.com>
        <20180703043655.GA9793@kroah.com>
        <20180703044302epcas1p4ff5961129c010a2df3548cf678b6274c~9wjUy-vFW2959129591epcas1p4p@epcas1p4.samsung.com>
        <CA+55aFz-K8s-Sh86PqxRaXTD5pG=YsVUCxf9ue8XOSaGmg-brw@mail.gmail.com>
        <20180705005205.GC30522@ZenIV.linux.org.uk>
        <20180808100622epcas1p1d4e3d6f858a9de3014f6d79bf284ff2c~I4L612J9p0428204282epcas1p1X@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 08월 08일 19:06, Seung-Woo Kim wrote:
> On 2018년 07월 05일 09:52, Al Viro wrote:
>> On Mon, Jul 02, 2018 at 10:01:25PM -0700, Linus Torvalds wrote:
>>> On Mon, Jul 2, 2018 at 9:43 PM Seung-Woo Kim <sw0312.kim@samsung.com> wrote:
>>>>
>>>> I think the commit itself is required. Simple, but not reliable,
>>>> workaround fix is like below:
>>>>
>>>> diff --git a/fs/dcache.c b/fs/dcache.c
>>>> index a34d401..7c751f2 100644
>>>> --- a/fs/dcache.c
>>>> +++ b/fs/dcache.c
>>>> @@ -1879,6 +1879,8 @@ void d_instantiate_new(struct dentry *entry,
>>>> struct inode *inode)
>>>>         BUG_ON(!hlist_unhashed(&entry->d_u.d_alias));
>>>>         BUG_ON(!inode);
>>>>         lockdep_annotate_inode_mutex_key(inode);
>>>> +       /* WORKAROUND for calling security_d_instantiate() */
>>>> +       entry->d_inode = inode;
>>>>         security_d_instantiate(entry, inode);
>>>>         spin_lock(&inode->i_lock);
>>>>         __d_instantiate(entry, inode);
>>>
>>> Ugh. That looks horrible even if it might avoid the oops.
>>>
>>> I think a much better solution is to back-port commit b296821a7c42
>>> ("xattr_handler: pass dentry and inode as separate arguments of
>>> ->get()") to older kernels. Then the inode is passed down all the way,
>>> and you don't have people try to get it from the (not yet initialized)
>>> dentry.
>>>
>>> But there might be other parts missing too, and I didn't look at how
>>> easy/painful that backport would be.
>>>
>>> Al - comments? This is all because of commit 1e2e547a93a0 ("do
>>> d_instantiate/unlock_new_inode combinations safely") being marked for
>>> stable, and various cases of security_d_instantiate() calling down to
>>> getxattr. Which used to not get the inode at all, so those older
>>> kernels use d_inode(dentry), which doesn't work in this path since
>>> dentry->d_inode hasn't been instantiated yet..
>>
>> You also want b96809173e94 and ce23e6401334 there...
> 
> For above two commits, also b296821a7c42 is required. And after
> backport, smack still crashed because setxattr. To fix it, 5930122683df
> and 3767e255b390 are also required.
> 
> By the way, does no one have met this kind getxattr crash issue with
> selinux from 3.18.y?
> 

I have checked with selinux, and it is confirmed that there is no crash
because selinux_d_instantiate() has null check for inode. So, it is only
security smack issue.

-- 
Seung-Woo Kim
Samsung Research
--

