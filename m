Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5BFC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567A6206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547516416;
	bh=Jg0GHLkim+3GwLV0POY2siTHfZdujuJmuotMca9hQAs=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=H0uEjut2EZrtr5HDSxJrxRoKFmiHEwhbP2oV83wM3wvZyn+61hc32w5uje/TxI25E
	 7hsEIBzdgWuxRUkU3Wp4AjkXuP0d8JSBOPyTBM2eo+2gwS9BjtxBCXS1peATYXlOTq
	 O0W+EmLm6axJLV7qoTH4rnGQiOgmnzi8iuEqb7Rc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfAOBkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 20:40:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:43570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfAOBkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 20:40:14 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C36C320659;
        Tue, 15 Jan 2019 01:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547516413;
        bh=Jg0GHLkim+3GwLV0POY2siTHfZdujuJmuotMca9hQAs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=07x4MyEwXGVs8b3kScbZ8V424XnyDrQYcw2QCnmsKc8vdLwhXuTqH8CjiCQv0VIdA
         6kxU5XbQjBXNcm+86WucAzhSqXvmojQRnru8KFzxbtkOaZwTQY/9KThkKAQM5g1C4n
         6GvzprpABeiIzsVWy672aTF0WaU6LpG4pmJbbYkA=
Subject: Re: [PATCH v4 2/2] selftests/memfd: Add tests for F_SEAL_FUTURE_WRITE
 seal
To:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Cc:     dancol@google.com, minchan@kernel.org,
        Jann Horn <jannh@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org,
        =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        shuah <shuah@kernel.org>
References: <20190112203816.85534-1-joel@joelfernandes.org>
 <20190112203816.85534-3-joel@joelfernandes.org>
From:   shuah <shuah@kernel.org>
Message-ID: <f9ffb7f8-1ff8-3bec-ce79-f9322d8715dc@kernel.org>
Date:   Mon, 14 Jan 2019 18:39:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190112203816.85534-3-joel@joelfernandes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/19 1:38 PM, Joel Fernandes wrote:
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> Add tests to verify sealing memfds with the F_SEAL_FUTURE_WRITE works as
> expected.
> 
> Cc: dancol@google.com
> Cc: minchan@kernel.org
> Cc: Jann Horn <jannh@google.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---

Looks good to me. For selftest part of the series:

Reviewed-by: Shuah Khan <shuah@kernel.org>

thanks,
-- Shuah
