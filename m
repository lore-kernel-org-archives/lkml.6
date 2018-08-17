Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91711C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 360C1218EB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DCv4Cy4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 360C1218EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbeHQPKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 11:10:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48932 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeHQPKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 11:10:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7HC4Sb3055783;
        Fri, 17 Aug 2018 12:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=FPUlUKDB3ODcLNLFcu/zKrqH6md56lXSnU/86EH4SCo=;
 b=DCv4Cy4NaPl+Ju0a0vklEJyPpwbVTRFWqLPWA/NC4of6cs7xCMVhNfRRZWd3+dB7lLzc
 yvTSqg3TSRqV4Fy/pm2Z5k7L/sQ6Xd9Ql+TkDxeoY08VRQJ9rOFbgoPyp8SAOftHh/me
 wkwGJ2EX/zuPI7Jp7jELtsUw4kHRZru2VQ8kXKc4kNXQyCdl2rIUgLXPvAaDL3GW7+gJ
 YBEGjAKvh5gtA832+ImBQesIL80XqKEzIkTol3pd7tAx7AdyWtUvkLgXsnqi1+bsN6QM
 XX4/EdFxeVUEcbvELeNaP4oSQk5NLJJlfqammv+3GgKa9veB7mGrquJwatRpfAMyz0Vd lA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2ksreqf2ba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Aug 2018 12:07:02 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7HC70p0032175
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Aug 2018 12:07:00 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7HC6xpG021115;
        Fri, 17 Aug 2018 12:06:59 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Aug 2018 05:06:58 -0700
Date:   Fri, 17 Aug 2018 15:06:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Security Officers <security@kernel.org>,
        Kevin Deus <kdeus@google.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Allen Pais <allen.pais@oracle.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFC: Fix possible memory corruption when handling
 SHDLC I-Frame commands
Message-ID: <20180817120650.6mx6icxif2o52qyx@mwanda>
References: <20180814095413.vbjkcjkmytkffyaz@mwanda>
 <CAJuCfpF0Y6wc1z-rbn2wdWROgc_FkD2EX5HzDMcZ1oB5Z=dXSw@mail.gmail.com>
 <CAJuCfpHSZuabLr6+t_n7UDamJCAP6EPTNEZ6kNqWOhk2mpYADg@mail.gmail.com>
 <CAGXu5jKqcpbpG0Ky4-yXV4d5q10HtGwJtdyPKcrwkJUPhA_Mpg@mail.gmail.com>
 <CAJuCfpEX69Sbd=0i0ismP6q2NsZGUF4gMSCr1G5NdXd3n1NyZA@mail.gmail.com>
 <CAGXu5jJB9wMDJnfsurpxsXm6_0WsWWCaTuWBfy+3aMSE_LL9Rw@mail.gmail.com>
 <CAJuCfpEX+F-EPxQYXNdUg-uT9ecwYYdxBsr9y_69zQ0Fq50GeA@mail.gmail.com>
 <CAJuCfpGSPkB-tk4GHaJeStRph-ibVhUZ119Sfd16xgf9x=qUwQ@mail.gmail.com>
 <20180815082956.u6grueiyshwgqt3a@mwanda>
 <CAJuCfpH9n2vVjBF7RoMNng3T=URY1eusKfbVGyq44LWcjwNTPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpH9n2vVjBF7RoMNng3T=URY1eusKfbVGyq44LWcjwNTPw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8987 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808170133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 09:40:13AM -0700, Suren Baghdasaryan wrote:
> On Wed, Aug 15, 2018 at 1:29 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > On Tue, Aug 14, 2018 at 03:38:14PM -0700, Suren Baghdasaryan wrote:
> >> The separate fix for the size of pipes[] array is posted here:
> >> https://lkml.org/lkml/2018/8/14/1034
> >> Thanks!
> >>
> >
> > That's great!  Let's add some bounds checking to nfc_hci_msg_rx_work()
> > and nfc_hci_recv_from_llc() as well and then we can close the chapter on
> > these bugs.
> 
> Dan, I don't think we need additional checks there. Here are the
> relevant parts of the code in nfc_hci_recv_from_llc():
>

Sorry, I meant after that at the end of the function:

net/nfc/hci/core.c
   902          /* if this is a response, dispatch immediately to
   903           * unblock waiting cmd context. Otherwise, enqueue to dispatch
   904           * in separate context where handler can also execute command.
   905           */
   906          packet = (struct hcp_packet *)hcp_skb->data;
   907          type = HCP_MSG_GET_TYPE(packet->message.header);
   908          if (type == NFC_HCI_HCP_RESPONSE) {
   909                  pipe = packet->header;
                        ^^^^^^^^^^^^^^^^^^^^^
Pipe can go up to 255.

   910                  instruction = HCP_MSG_GET_CMD(packet->message.header);
   911                  skb_pull(hcp_skb, NFC_HCI_HCP_PACKET_HEADER_LEN +
   912                           NFC_HCI_HCP_MESSAGE_HEADER_LEN);
   913                  nfc_hci_hcp_message_rx(hdev, pipe, type, instruction, hcp_skb);
                                                     ^^^^
Then inside the nfc_hci_hcp_message_rx() function we call
nfc_hci_cmd_received() and nfc_hci_event_received() which use it as an
array index.

   914          } else {
   915                  skb_queue_tail(&hdev->msg_rx_queue, hcp_skb);
   916                  schedule_work(&hdev->msg_rx_work);
   917          }
   918  }

It's the same thing when nfc_hci_hcp_message_rx() is called from
nfc_hci_msg_rx_work():

   138  static void nfc_hci_msg_rx_work(struct work_struct *work)
   139  {
   140          struct nfc_hci_dev *hdev = container_of(work, struct nfc_hci_dev,
   141                                                  msg_rx_work);
   142          struct sk_buff *skb;
   143          struct hcp_message *message;
   144          u8 pipe;
   145          u8 type;
   146          u8 instruction;
   147  
   148          while ((skb = skb_dequeue(&hdev->msg_rx_queue)) != NULL) {
   149                  pipe = skb->data[0];
                        ^^^^^^^^^^^^^^^^^^^
   150                  skb_pull(skb, NFC_HCI_HCP_PACKET_HEADER_LEN);
   151                  message = (struct hcp_message *)skb->data;
   152                  type = HCP_MSG_GET_TYPE(message->header);
   153                  instruction = HCP_MSG_GET_CMD(message->header);
   154                  skb_pull(skb, NFC_HCI_HCP_MESSAGE_HEADER_LEN);
   155  
   156                  nfc_hci_hcp_message_rx(hdev, pipe, type, instruction, skb);
                                                     ^^^^
   157          }
   158  }

regards,
dan carpenter
