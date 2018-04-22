Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49iTHRibFvxVQThuv8VFuqLWcH92c+VtO8D2lMoWzxn55MzVnn4Yc+c8IF+Eg2HK3QFrMGl
ARC-Seal: i=1; a=rsa-sha256; t=1524405613; cv=none;
        d=google.com; s=arc-20160816;
        b=xtJdJB1spbh7Pgs1+0zoaQjoJv5btQxrg4BD+h64u7C1DyJeCstHHGgF4kk9OZLkTv
         fmFW1Sz89HfO4dnZFy0WlN6DrZC8R1APYhb8luWXDB13sbklZO5ykNOq4do3VDIIfULT
         Cxx8eT0/AsxB0YXlj0S70kPEuJiFUJD2UNAo1mZD5ZXX5bVb/5itHtmqcoIWaA4w/+Ef
         52sZxIY52DqbIEpQv96rdvSCvcYGSgHo+ZVM4iRSi7/nZD+Gvki5N27/dEDUQmrVsc5C
         KZMxf4D32uU3Ahdn7apqXxd3NPI33W5Jsh9oIh4tANaZkcdIOubV4w/K+SmrFLTcaK2y
         sOBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RaQvu7DFlGkCtD1HrItopWGMlzCTXz+o+2eYw3vvYQ0=;
        b=STd+nI9YBex86ik4X7bF21h7wGPK2zZGE/zVee/YNJpLuaKtcn4Iwxyjxrj+DxsRyn
         yrean6/n9LsLFBJ7z5+2uC5gjpQI3QzV7LRaCFDW9aL+61OG2sryJcckGKJ5IJCchvWK
         ByAJc+bGpynzNtFSKu/ET1y235f+D0T1ZAnFr1lO09XjP2D07o6SAwzs8dChcDOMW52B
         T/UCEH47etSVyE+ubhB3MlxH+BHXHC6w1DZdFRb4ahJh6QxWoachIwV9Cf4ePJzzaKBD
         qVJP9oGre3+PiwsPhHrV1wVZuiOGx6EjyTT2WHmUVWuB/uRk5bsszCH+nS6b4Ytjh3BE
         5myQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexander Kappner <agk@godking.net>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.16 131/196] mmc: core: Prevent bus reference leak in mmc_blk_init()
Date: Sun, 22 Apr 2018 15:52:31 +0200
Message-Id: <20180422135111.021365153@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455140484496141?=
X-GMAIL-MSGID: =?utf-8?q?1598455140484496141?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Kappner <agk@godking.net>

commit d0a0852b9f81cf5f793bf2eae7336ed40a1a1815 upstream.

Upon module load, mmc_block allocates a bus with bus_registeri() in
mmc_blk_init(). This reference never gets freed during module unload, which
leads to subsequent re-insertions of the module fails and a WARN() splat is
triggered.

Fix the bug by dropping the reference for the bus in mmc_blk_exit().

Signed-off-by: Alexander Kappner <agk@godking.net>
Fixes: 97548575bef3 ("mmc: block: Convert RPMB to a character device")
Cc: <stable@vger.kernel.org>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/core/block.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -3087,6 +3087,7 @@ static void __exit mmc_blk_exit(void)
 	mmc_unregister_driver(&mmc_driver);
 	unregister_blkdev(MMC_BLOCK_MAJOR, "mmc");
 	unregister_chrdev_region(mmc_rpmb_devt, MAX_DEVICES);
+	bus_unregister(&mmc_rpmb_bus_type);
 }
 
 module_init(mmc_blk_init);
