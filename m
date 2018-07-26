Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107C4C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B549B20647
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B549B20647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388531AbeGZSIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 14:08:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731732AbeGZSIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 14:08:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6279B87927;
        Thu, 26 Jul 2018 16:50:24 +0000 (UTC)
Received: from [10.10.121.247] (ovpn-121-247.rdu2.redhat.com [10.10.121.247])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 70BBA2142F20;
        Thu, 26 Jul 2018 16:50:23 +0000 (UTC)
Subject: Re: [PATCH 18/26] target/iscsi: Allocate session IDs from an IDA
To:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org
References: <20180621212835.5636-1-willy@infradead.org>
 <20180621212835.5636-19-willy@infradead.org> <5B59FB56.9090901@redhat.com>
Cc:     "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Varun Prakash <varun@chelsio.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5B59FBCF.7080305@redhat.com>
Date:   Thu, 26 Jul 2018 11:50:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <5B59FB56.9090901@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 26 Jul 2018 16:50:24 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 26 Jul 2018 16:50:24 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mchristi@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/26/2018 11:48 AM, Mike Christie wrote:
> On 06/21/2018 04:28 PM, Matthew Wilcox wrote:
> 
>> @@ -1163,11 +1157,9 @@ void iscsi_target_login_sess_out(struct iscsi_conn *conn,
>>  		goto old_sess_out;
>>  	if (conn->sess->se_sess)
>>  		transport_free_session(conn->sess->se_sess);
>> -	if (conn->sess->session_index != 0) {
>> -		spin_lock_bh(&sess_idr_lock);
>> -		idr_remove(&sess_idr, conn->sess->session_index);
>> -		spin_unlock_bh(&sess_idr_lock);
> 
> This code looks buggy. We will probably NULL pointer oops before we hit it.

Sorry did not mean null pointer, but some crash due to accessing memory
that was freed.

> 
> It looks like the session_index check was supposed to detect when login
> fails in the middle of doing login, so that code probably wanted to do:
> 
> idr_alloc(&sess_idr, NULL, 1, 0, GFP_NOWAIT);
> 
> The problem is that iscsi_login_zero_tsih_s1 sets conn->sess early in
> iscsi_login_set_conn_values. If the function fails later like when we
> alloc the idr it does kfree(sess) and leaves the conn->sess pointer set.
> iscsi_login_zero_tsih_s1 then returns -Exyz and we then call
> iscsi_target_login_sess_out and access the freed memory above.
> 
> So I am not sure what we want to do here for your patch since it is not
> adding any new bugs. Just merge your patch now and I can send a fix for
> the above bug over it?
> 
> 
>> -	}
>> +	/* Um, 0 is a valid ID.  I suppose we never free it? */
>> +	if (conn->sess->session_index != 0)
>> +		ida_free(&sess_ida, conn->sess->session_index);
>>  	kfree(conn->sess->sess_ops);
>>  	kfree(conn->sess);
>>  	conn->sess = NULL;
>>
> 

