Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCE8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3006620870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbfAKGSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 01:18:32 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:43976 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728042AbfAKGSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 01:18:32 -0500
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0B6GVWI009198;
        Fri, 11 Jan 2019 00:18:30 -0600
Received: from ni.com (skprod2.natinst.com [130.164.80.23])
        by mx0a-00010702.pphosted.com with ESMTP id 2pxcvnh90e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Jan 2019 00:18:30 -0600
Received: from us-aus-exhub1.ni.corp.natinst.com (us-aus-exhub1.ni.corp.natinst.com [130.164.68.41])
        by us-aus-skprod2.natinst.com (8.16.0.27/8.16.0.27) with ESMTPS id x0B6IT34014776
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 11 Jan 2019 00:18:29 -0600
Received: from us-aus-exch3.ni.corp.natinst.com (130.164.68.13) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Fri, 11 Jan 2019 00:18:29 -0600
Received: from us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) by
 us-aus-exch3.ni.corp.natinst.com (130.164.68.13) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Fri, 11 Jan 2019 00:18:28 -0600
Received: from my-pen-rd24.apac.corp.natinst.com (130.164.49.7) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 id 15.0.1395.4 via Frontend Transport; Fri, 11 Jan 2019 00:18:27 -0600
From:   Guan Yung Tseng <guan.yung.tseng@ni.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Guan Yung Tseng" <guan.yung.tseng@ni.com>
Subject: Re:[PATCH] 8250_pci.c: Only check for communication class in serial_pci_guess_board
Date:   Fri, 11 Jan 2019 14:18:07 +0800
Message-ID: <1547187487-10056-1-git-send-email-guan.yung.tseng@ni.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-11_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 04:12:12PM +0800, Guan Yung Tseng wrote:
> Some multiport serial cards, such as the NI PXI-8430/2, NI PXI-8430/8,
> and NI PXI-8432/4 use PCI_CLASS_COMMUNICATION_OTHER and this fail the
> serial_pci_is_class_communication test added in the commit 7d8905d06405
> ("serial: 8250_pci: Enable device after we check black list").
> 
> Since these devices are correctly listed in serial_pci_tbl, we
> shouldn't need to check the PCI class IDs. This change relocates the
> class checking solely into "serial_pci_guess_board" where it had been
> before so that the class-check doesn't hinder initialization.
> 
> Signed-off-by: Guan Yung Tseng <guan.yung.tseng@ni.com>
> ---
>  drivers/tty/serial/8250/8250_pci.c | 28 +++++++++-------------------
>  1 file changed, 9 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 4986b4a..e33a869 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -3382,21 +3382,6 @@ static const struct pci_device_id blacklist[] = {
>  	{ PCI_VDEVICE(COMMTECH, PCI_ANY_ID), },
>  };
>  
> -static int serial_pci_is_class_communication(struct pci_dev *dev)
> -{
> -	/*
> -	 * If it is not a communications device or the programming
> -	 * interface is greater than 6, give up.
> -	 */
> -	if ((((dev->class >> 8) != PCI_CLASS_COMMUNICATION_SERIAL) &&
> -	     ((dev->class >> 8) != PCI_CLASS_COMMUNICATION_MULTISERIAL) &&
> -	     ((dev->class >> 8) != PCI_CLASS_COMMUNICATION_MODEM)) ||
> -	    (dev->class & 0xff) > 6)
> -		return -ENODEV;
> -
> -	return 0;
> -}

>
> Noted.
>

Please leave this as a function, no need to move it inside another
function at this point in time.


>  static int serial_pci_is_blacklisted(struct pci_dev *dev)
>  {
>  	const struct pci_device_id *bldev;
> @@ -3427,6 +3412,15 @@ serial_pci_guess_board(struct pci_dev *dev, struct pciserial_board *board)
>  	int num_iomem, num_port, first_port = -1, i;
>  
>  	/*
> +	 * If it is not a communications device or the programming
> +	 * interface is greater than 6, give up.
> +	 *
> +	 */
> +	if ((((dev->class >> 8) != PCI_CLASS_COMMUNICATION_SERIAL) &&
> +	     ((dev->class >> 8) != PCI_CLASS_COMMUNICATION_MODEM)) ||
> +	    (dev->class & 0xff) > 6)
> +		return -ENODEV;
> +	/*

>
> It was my mistake. I should not remove it.
> I will fix them and submit another patch.
>

what happened to the multiserial check?

You should just call the function here.

thanks,

greg k-h

