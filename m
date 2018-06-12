Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6849DC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A8E2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JVddtvD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A8E2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933713AbeFLVK2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 17:10:28 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55528 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933912AbeFLVK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 17:10:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5CL6HdO086442;
        Tue, 12 Jun 2018 21:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=+7qepDaPWnQevdYs0uJ75WwfBIC3xEzD2qhhfGEkLpM=;
 b=JVddtvD/uL3kq6Msd5j096dOTs0kAaa6kO+J/J8JOVr8ovnxFPDekOjdlUVVd+sREATQ
 VeqYHkSnMeT5rpiXbCn3RbT7/bTUAE+JgPTrCfmkkqRrKajmO4Jv82UMyjk4PcykZhv1
 JBp156NPlV3YbPGoQzptfmZrWGzY3aePGyEzNMIVb9pUkgHjA2VI+FP5jrYOaRkrgbcF
 Lhw12tiXeV7ZhIElQAmtd4C2JaDkCc29AxMMMBnskRsyspbB5sBKJ4vXN59RiVYF4Tt7
 nx3kjctyUbgnNCJBEAF23lY8Z0kvba017k66SAdAucreGUkla7fAja7kqJ4wOEQ74eIA PQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2jgecxk35g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 21:09:45 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5CL9i0Q014130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 21:09:45 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5CL9hGq017829;
        Tue, 12 Jun 2018 21:09:43 GMT
Received: from char.us.oracle.com (/10.137.176.158)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jun 2018 14:09:43 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 5922E6A00D6; Tue, 12 Jun 2018 17:09:40 -0400 (EDT)
Date:   Tue, 12 Jun 2018 17:09:40 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Anchal Agarwal <anchalag@amazon.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, boris.ostrovsky@oracle.com, roger.pau@citrix.com,
        netdev@vger.kernel.org, jgross@suse.com,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        kamatam@amazon.com, fllinden@amazon.com, vallish@amazon.com,
        guruanb@amazon.com, eduval@amazon.com, rjw@rjwysocki.net,
        pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org,
        cyberax@amazon.com
Subject: Re: [RFC PATCH 00/12] Enable PM hibernation on guest VMs
Message-ID: <20180612210940.GA17709@char.us.oracle.com>
References: <20180612205619.28156-1-anchalag@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612205619.28156-1-anchalag@amazon.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8922 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=943
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806120234
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 08:56:07PM +0000, Anchal Agarwal wrote:
> Hello,
> I am sending out a series of patches that implements guest
> PM hibernation. These guests are running on xen hypervisor.
> The patches had been tested against mainstream kernel and latest
> xen version-4.11. EC2 instance hibernation feature is provided to
> the AWS EC2 customers. PM hibernation uses swap space where
> hibernation image is stored and restored from. I would like
> the community to review and provide some feedback on the patch 
> series and if they look good, merge them into 4.17 kernel.

4.17 got released on Jun 3rd. Kind of hard to do a time-machine.
